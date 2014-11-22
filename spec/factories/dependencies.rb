# == Schema Information
#
# Table name: dependencies
#
#  id         :integer          not null, primary key
#  word       :string(255)      not null
#  counter    :integer          default(0), not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_dependencies_on_word  (word)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :dependency do
  end
end
