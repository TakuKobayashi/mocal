# == Schema Information
#
# Table name: mst_api_configs
#
#  id         :integer          not null, primary key
#  type       :string(255)      not null
#  api_key    :string(255)      not null
#  secret     :string(255)
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_mst_api_configs_on_type  (type)
#

class Mst::TwitterApi < Mst::ApiConfig
  def self.search_tweet(text)
    api = Mst::TwitterApi.first
    client = Twitter::REST::Search.new do |config|
      config.consumer_key        = api.api_key
      config.consumer_secret     = api.secret
    end
    client.search(text + " -rt", lang: "ja")
  end
end
