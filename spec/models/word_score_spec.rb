# == Schema Information
#
# Table name: word_scores
#
#  id            :integer          not null, primary key
#  sentence_id   :integer          not null
#  dependency_id :integer
#  word          :string(255)      not null
#  score         :float(24)        default(0.0), not null
#  created_at    :datetime
#  updated_at    :datetime
#
# Indexes
#
#  index_word_scores_on_sentence_id  (sentence_id)
#  index_word_scores_on_word         (word)
#

require 'rails_helper'

RSpec.describe WordScore, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
