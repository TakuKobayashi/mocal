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
#
# Indexes
#
#  index_tweets_on_post_at  (post_at)
#  index_tweets_on_type     (type)
#  index_tweets_on_uid      (uid)
#

FactoryGirl.define do
  factory :tweet do
    
  end

end
