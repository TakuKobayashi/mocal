# == Schema Information
#
# Table name: mst_api_feature_configs
#
#  id                     :integer          not null, primary key
#  mst_api_config_id      :integer          not null
#  category               :integer          not null
#  request_url            :string(255)      not null
#  request_format         :integer          not null
#  limit_count            :integer
#  limit_request_capacity :integer
#  limited_at             :datetime
#  created_at             :datetime
#  updated_at             :datetime
#
# Indexes
#
#  mst_api_feature_configs_request_index  (mst_api_config_id,category,request_url) UNIQUE
#

class Mst::ApiFeatureConfig < ActiveRecord::Base
  belongs_to :api_config
  has_many   :api_use_logs, class_name: "ApiUseLog", foreign_key: "mst_api_feature_config_id"

  enum request_format: [
    :json,
    :xml
  ]

  enum category: [
    :morphological_analysis,
    :article,
    :torendo,
    :environment_sensor,
    :environment_data
  ]

  def parse_to_hash(result)
    if self.request_format.to_sym == :json
      hash = JSON.parse(result)
    elsif self.request_format.to_sym == :xml
      hash = Hash.from_xml(result)
    end
    return hash
  end

  def request_api(method = :post, params = {}, header = {})
    http_client = HTTPClient.new
    response = http_client.send(method, self.request_url, params, header)
    return self.parse_to_hash(response.body)
  end
end
