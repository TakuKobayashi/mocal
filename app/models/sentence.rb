# == Schema Information
#
# Table name: sentences
#
#  id         :integer          not null, primary key
#  article_id :integer          not null
#  body       :text
#  score      :float(24)        default(0.0), not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_sentences_on_article_id  (article_id)
#

class Sentence < ActiveRecord::Base
  has_many :dependencies
  has_many :morphological_analysis
end
