# == Schema Information
#
# Table name: dependencies
#
#  id          :integer          not null, primary key
#  sentence_id :integer          not null
#  word        :string(255)
#  score       :float(24)        default(0.0), not null
#  pos         :string(255)      not null
#  created_at  :datetime
#  updated_at  :datetime
#
# Indexes
#
#  index_dependencies_on_pos          (pos)
#  index_dependencies_on_sentence_id  (sentence_id)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :dependency do
  end
end
