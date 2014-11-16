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
  has_many :sentences
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

  def analize!
    sentences = self.sentences
    results = Mst::XingApi.request_text_analize_api(sentences.pluck(:body).join("<!--p-->"))
    self.transaction do
      results.each_with_index do |data, index|
        data.each do |key, value|
          list = []
          s = sentences[index]
          if value.instance_of?(Array)
            value.each do |v|
              list << s.send(key.pluralize).new(v)
            end
            dlist, alist = list.partition{|klass| klass.instance_of?(Dependency) }
            Dependency.import(dlist)
            MorphologicalAnalysis.import(alist)
            s.reload
          else
            s.update!(score: Sentence::SCORE_LIST[value.to_i])
          end
        end
      end
      sentences.reload
      self.score = sentences.sum(:score)
      self.save!
    end
  end
end
