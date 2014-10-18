# == Schema Information
#
# Table name: sent_logs
#
#  id         :integer          not null, primary key
#  event_id   :integer          not null
#  address    :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_sent_logs_on_address   (address)
#  index_sent_logs_on_event_id  (event_id)
#

class SentLog < ActiveRecord::Base
  belongs_to :event
end
