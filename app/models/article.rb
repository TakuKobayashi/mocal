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

  def analize!
    sentences = self.sentences
    results = Mst::XingApi.request_text_analize_api(sentences.pluck(:body).join("<!--p-->"))
    list = []
    results.each_with_index do |data, index|
      data.each do |key, value|
        list << sentences[index].send(key.pluralize).new(value)
        sentences[index].save!
      end
    end
    dlist, alist = list.partition{|klass| klass.instance_of?(Dependency) }
    Dependency.import(dlist)
    MorphologicalAnalysis.import(alist)
    sentences.reload
    self.score = sentences.sum(:score)
    self.save!
  end
end
