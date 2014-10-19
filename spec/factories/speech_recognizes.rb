# == Schema Information
#
# Table name: speech_recognizes
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  status     :integer          not null
#  token      :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_speech_recognizes_on_token               (token) UNIQUE
#  index_speech_recognizes_on_user_id_and_status  (user_id,status)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :speech_recognize do
  end
end
