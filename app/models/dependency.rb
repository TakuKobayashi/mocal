# coding: utf-8
# == Schema Information
#
# Table name: dependencies
#
#  id          :integer          not null, primary key
#  sentence_id :integer          not null
#  word        :string(255)
#  score       :float(24)        default(0.0), not null
#  created_at  :datetime
#  updated_at  :datetime
#
# Indexes
#
#  index_dependencies_on_sentence_id  (sentence_id)
#

class Dependency < ActiveRecord::Base
  #  0:評価なし 1:ポジティブ 2:ネガティブ
  SCORE_LIST = {
    0 => 0,
    1 => 1,
    2 => -1
  }
  belongs_to :sentence
end
