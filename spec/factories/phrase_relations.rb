# == Schema Information
#
# Table name: phrase_relations
#
#  id            :integer          not null, primary key
#  morpheme_id   :integer          not null
#  dependency_id :integer          not null
#  source_type   :string(255)      not null
#  source_id     :integer          not null
#  created_at    :datetime
#  updated_at    :datetime
#
# Indexes
#
#  dependencies_index                                   (dependency_id,source_type,source_id)
#  index_phrase_relations_on_source_type_and_source_id  (source_type,source_id)
#  morphemes_index                                      (morpheme_id,source_type,source_id)
#

FactoryGirl.define do
  factory :phrase_relation do
    
  end

end
