# == Schema Information
#
# Table name: ngrams
#
#  id         :integer          not null, primary key
#  word       :string(255)      not null
#  counter    :integer          default(0), not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_ngrams_on_word  (word)
#

FactoryGirl.define do
  factory :ngram do
    
  end

end
