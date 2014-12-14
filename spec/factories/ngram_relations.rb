# == Schema Information
#
# Table name: ngram_relations
#
#  id          :integer          not null, primary key
#  source_type :string(255)      not null
#  source_id   :integer          not null
#  ngram_id    :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#
# Indexes
#
#  index_ngram_relations_on_ngram_id  (ngram_id)
#  ngram_index                        (source_type,source_id,ngram_id)
#

FactoryGirl.define do
  factory :ngram_relation do
    
  end

end
