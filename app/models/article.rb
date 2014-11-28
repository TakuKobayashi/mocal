# coding: utf-8
# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  score      :float(24)        default(0.0), not null
#  type       :string(255)      not null
#  body       :text(16777215)
#  title      :string(255)
#  post_at    :datetime
#  category   :integer
#  data_id    :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_articles_on_data_id  (data_id)
#  index_articles_on_post_at  (post_at)
#

class Article < ActiveRecord::Base
  has_many :sentences, as: :source
  has_many :company_source_relation, as: :source

  CATEGORY = {
    "地方"=>0,
    "社会"=>1,
    "科学医療"=>2,
    "文化芸能"=>3,
    "オピニオン"=>4,
    "生活"=>5,
    "スポーツ"=>6,
    "テレビ"=>7,
    "読書"=>8,
    "教育"=>9,
    "囲碁将棋"=>10,
    "小説"=>11,
    "サッカー"=>12,
    "総合"=>13,
    "外報"=>14,
    "経済"=>15,
    "政治"=>16,
    "商況"=>17,
    "環境"=>18,
    "高校野球"=>19,
    "号外"=>20,
    "その他"=>21
  }

  def split_sentences!
    list = []
    self.body.split(/\s*(\n|。|\t|　)\s*/).each do |b|
      next if b.blank? || b.length <= 1
      list << self.sentences.new(body: b)
    end
    Sentence.import(list)
    self.reload
  end

  def make_company_relation!(mst_company_id)
    list = []
    list << CompanySourceRelation.new(source: self, mst_company_id: mst_company_id)
    self.sentences.each do |sentence|
      list << CompanySourceRelation.new(source: sentence, mst_company_id: mst_company_id)
    end
    CompanySourceRelation.import(list)
  end

  def self.bulk_analize!
    a = PhraseRelation.where(source_type: "Sentence").last.source.source
    crawl_log = CrawlLog.find_or_initialize_by(data: a)
    if crawl_log.new_record?
      crawl_log.crawl_at = Time.current
      crawl_log.status = :stanby
      crawl_log.save!
    end
    return if crawl_log.crawling?
    crawl_log.crawling!
    articles = Article.where("id > ?", a.id).limit(100)
    return if articles.blank?
    articles.each do |article|
      article.transaction do
        article.analize!
      end
    end
    crawl_log.data_id = articles.last.id
    if articles.last.id >= crawl_log.max_crawl_number.to_i
      crawl_log.status = :complete
    else
      crawl_log.current_crawl_number = articles.last.id
      crawl_log.status = :remain
    end
    crawl_log.crawl_at = Time.current
    crawl_log.save!

    rescue => e
    crawl_log.stanby!
    puts e.message
  end

  def analize!
    relation_list = []
    word_score_list = []
    sentences = self.sentences
    
    sentences.find_in_batches(batch_size: Mst::XingApi::LIMIT_SENDABLE_SENTENCES) do |sentences_list|
      results = Mst::XingApi.request_text_analize_api(sentences_list.map(&:body).join("<!--p-->"))
      self.transaction do
        results.each_with_index do |data, index|
          dependency_ids = []
          morpheme_ids = []
          sentence = sentences[index]
          sentence.update!(score: data["score"].to_f)
          data["dependencies"].each do |d|
            dependency = Dependency.find_or_create_by(word: d["morphemes"].map{|m| m["word"]}.join(""))
            dependency_ids << dependency.id
            word_list = []
            d["morphemes"].each do |hash|
              morpheme = Morpheme.find_or_create_by(hash)
              morpheme_ids << morpheme.id
              word_list << morpheme.word if morpheme.pos == "名詞"
              relation_list << PhraseRelation.new(source: sentence, morpheme: morpheme, dependency: dependency)
            end
            word_list.each do |w|
              word_score_list << sentence.word_scores.new(dependency_id: dependency.id, word: w, score: d["score"])
            end
          end
          Dependency.where(id: dependency_ids).update_all("counter = counter + 1")
          Morpheme.where(id: morpheme_ids).update_all("counter = counter + 1")
        end
        WordScore.import(word_score_list)
        PhraseRelation.import(relation_list)
        sentences.reload
        self.score = sentences.sum(:score)
        self.save!
      end
    end
  end
end
