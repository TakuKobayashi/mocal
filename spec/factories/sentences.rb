# == Schema Information
#
# Table name: sentences
#
#  id               :integer          not null, primary key
#  source_type      :string(255)      not null
#  source_id        :integer          not null
#  origin_sentence  :text
#  fixture_sentence :text
#  status           :integer          not null
#  language_code    :string(255)      not null
#  created_at       :datetime
#  updated_at       :datetime
#
# Indexes
#
#  index_sentences_on_source_type_and_source_id  (source_type,source_id)
#  index_sentences_on_status                     (status)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sentence do
  end
end
