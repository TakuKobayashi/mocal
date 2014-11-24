# coding: utf-8
# == Schema Information
#
# Table name: sentences
#
#  id          :integer          not null, primary key
#  source_type :string(255)      not null
#  source_id   :integer          not null
#  body        :text
#  score       :float(24)        default(0.0), not null
#  created_at  :datetime
#  updated_at  :datetime
#
# Indexes
#
#  index_sentences_on_source_type_and_source_id  (source_type,source_id)
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
  belongs_to :source, :polymorphic => true
  has_many :dependencies, through: :phrase_relations, source: :dependency
  has_many :morphemes, through: :phrase_relations, source: :morpheme
  has_many :phrase_relations, as: :source
  has_many :word_scores
end
