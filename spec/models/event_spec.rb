# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  type       :string(255)      not null
#  status     :integer          not null
#  token      :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_events_on_token                        (token) UNIQUE
#  index_events_on_user_id_and_type_and_status  (user_id,type,status)
#

require 'rails_helper'

RSpec.describe Event, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
