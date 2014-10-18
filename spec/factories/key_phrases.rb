# == Schema Information
#
# Table name: key_phrases
#
#  id          :integer          not null, primary key
#  sentence_id :integer          not null
#  word        :string(255)      not null
#  score       :float(24)        not null
#  created_at  :datetime
#  updated_at  :datetime
#
# Indexes
#
#  index_key_phrases_on_sentence_id  (sentence_id)
#  index_key_phrases_on_word         (word)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :key_phrase do
  end
end
