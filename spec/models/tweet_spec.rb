# == Schema Information
#
# Table name: tweets
#
#  id         :integer          not null, primary key
#  tweet      :string(255)      not null
#  uid        :string(255)
#  type       :string(255)      not null
#  post_at    :datetime
#  created_at :datetime
#  updated_at :datetime
#  score      :float(24)        default(0.0), not null
#  url        :string(255)
#
# Indexes
#
#  index_tweets_on_post_at  (post_at)
#  index_tweets_on_type     (type)
#  index_tweets_on_uid      (uid)
#

require 'rails_helper'

RSpec.describe Tweet, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
