# == Schema Information
#
# Table name: morphological_analyses
#
#  id            :integer          not null, primary key
#  sentence_id   :integer          not null
#  dependency_id :integer
#  surface       :string(255)      not null
#  reading       :string(255)
#  pos           :string(255)      not null
#  baseform      :string(255)
#  feature       :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#
# Indexes
#
#  index_morphological_analyses_on_pos                            (pos)
#  index_morphological_analyses_on_sentence_id_and_dependency_id  (sentence_id,dependency_id)
#  index_morphological_analyses_on_surface                        (surface)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :morphological_analysis do
  end
end
