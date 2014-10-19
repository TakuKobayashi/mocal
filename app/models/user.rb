# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  auth_token :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_users_on_auth_token  (auth_token) UNIQUE
#

class User < ActiveRecord::Base
  has_one  :device
  has_one  :user_attribute
  has_many :sns_configs
  has_many :speech_recognizes
  has_many :commets
  has_many :sentences
end
