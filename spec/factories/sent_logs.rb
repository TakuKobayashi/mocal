# == Schema Information
#
# Table name: sent_logs
#
#  id                  :integer          not null, primary key
#  speech_recognize_id :integer          not null
#  address             :string(255)      not null
#  created_at          :datetime
#  updated_at          :datetime
#
# Indexes
#
#  index_sent_logs_on_address              (address)
#  index_sent_logs_on_speech_recognize_id  (speech_recognize_id)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sent_log do
  end
end
