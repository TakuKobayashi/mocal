# == Schema Information
#
# Table name: sentences
#
#  id             :integer          not null, primary key
#  source_type    :string(255)      not null
#  source_id      :integer          not null
#  mst_company_id :integer          not null
#  body           :text
#  score          :float(24)        default(0.0), not null
#  created_at     :datetime
#  updated_at     :datetime
#
# Indexes
#
#  index_sentences_on_mst_company_id             (mst_company_id)
#  index_sentences_on_source_type_and_source_id  (source_type,source_id)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sentence do
  end
end
