# coding: utf-8
# == Schema Information
#
# Table name: articles
#
#  id             :integer          not null, primary key
#  mst_company_id :integer          not null
#  type           :string(255)      not null
#  score          :float(24)        default(0.0), not null
#  body           :text
#  title          :string(255)
#  post_at        :datetime
#  category       :integer
#  created_at     :datetime
#  updated_at     :datetime
#
# Indexes
#
#  index_articles_on_mst_company_id  (mst_company_id)
#  index_articles_on_post_at         (post_at)
#  index_articles_on_type            (type)
#

class Article < ActiveRecord::Base
  has_many :sentences, as: :source
  belongs_to :mst_company, class_name: "Mst::Company", foreign_key: :mst_company_id

  CATEGORY = {
  	0 => "地方",
  	1 => "社会",
  	2 => "科学医療",
  	3 => "文化芸能",
  	4 => "オピニオン",
  	5 => "生活",
  	6 => "スポーツ",
  	7 => "テレビ",
  	8 => "読書",
  	9 => "教育",
  	10 => "囲碁将棋",
  	11 => "小説",
  	12 => "サッカー",
  	13 => "総合",
  	14 => "外報",
  	15 => "経済",
  	16 => "政治",
  	17 => "商況",
  	18 => "環境",
  	19 => "高校野球",
  	20 => "号外",
  	21 => "その他",
  }

  def split_sentences!
    list = []
    self.body.split(/\s*(\n|。|\t|　)\s*/).each do |b|
      next if b.blank? || b.length <= 1
      list << self.sentences.new(body: b, mst_company_id: self.mst_company_id)
    end
    Sentence.import(list)
    self.reload
  end

  def analize!
    relation_list = []
    word_score_list = []
    sentences = self.sentences
    results = Mst::XingApi.request_text_analize_api(sentences.pluck(:body).join("<!--p-->"))
    self.transaction do
      results.each_with_index do |data, index|
        sentence = sentences[index]
        sentence.update!(score: data["score"].to_f)
        data["dependencies"].each do |d|
          dependency = Dependency.find_or_initialize_by(word: d["morphemes"].map{|m| m["word"]}.join(""))
          dependency.counter += 1
          dependency.save!
          word_list = []
          d["morphemes"].each do |hash|
            morpheme = Morpheme.find_or_initialize_by(hash)
            morpheme.counter += 1
            morpheme.save!
            word_list << morpheme.word if morpheme.pos == "名詞"
            relation_list << PhraseRelation.new(source: sentence, morpheme: morpheme, dependency: dependency)
          end
          word_list.each do |w|
            word_score_list << sentence.word_scores.new(dependency_id: dependency.id, word: w, score: d["score"])
          end
        end
      end
      WordScore.import(word_score_list)
      PhraseRelation.import(relation_list)
      sentences.reload
      self.score = sentences.sum(:score)
      self.save!
    end
  end
end
