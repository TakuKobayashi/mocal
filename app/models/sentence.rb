# coding: utf-8
# == Schema Information
#
# Table name: sentences
#
#  id             :integer          not null, primary key
#  article_id     :integer          not null
#  mst_company_id :integer
#  body           :text
#  score          :float(24)        default(0.0), not null
#  created_at     :datetime
#  updated_at     :datetime
#
# Indexes
#
#  index_sentences_on_article_id      (article_id)
#  index_sentences_on_mst_company_id  (mst_company_id)
#

class Sentence < ActiveRecord::Base
  #ポジティブ > 条件・期待 > 依頼 > ネガティブ
  SCORE_LIST = {
  	#0:評価なし
    0 => 0,
    #1: ポジティブ
    1 => 2,
    #2: ネガティブ
    2 => -2,
    #3: 条件•期待
    3 => 1,
    #4: 依頼
    4 => -1
  }
  belongs_to :mst_company, class_name: "Mst::Company", foreign_key: :mst_company_id
  has_many :dependencies
  has_many :morphological_analyses
end
