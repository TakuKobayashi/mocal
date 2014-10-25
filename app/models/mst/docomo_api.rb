# coding: utf-8
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

class Mst::DocomoApi < Mst::ApiConfig
  DATE_TYPE_NAME = {
    temperature: "気温正時値",
    rainfall: "降水量前1時間積算値",
    ultraviolet: "UV-index正時推定実況値"
  }

  DATA_TYPE = {
    temperature: 1013,
    rainfall: 1213,
    ultraviolet: 2221
  }

  #約500m
  ROUND = 0.00046

  def self.request_location_environment_api(lat, lon)
    mst_docomo_api = Mst::DocomoApi.first
    mst_docomo_api.api_feature_configs.map do |feature|
       hash = feature.request_api(:get, {"APIKEY" => mst_docomo_api.api_key, lat: lat, lot: lon, range: ROUND, with_data: true, data_type: DATA_TYPE[:ultraviolet], limit: "100,0"})
       puts hash
       hash
    end
  end
end
