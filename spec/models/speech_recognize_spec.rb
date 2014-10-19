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

require 'rails_helper'

RSpec.describe SpeechRecognize, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
