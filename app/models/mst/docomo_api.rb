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

  def self.import_senser_location(options = {})
  	 params = {with_data: false, data_type: DATA_TYPE[:ultraviolet], limit: "100,0"}.merge(options)
     mst_docomo_api = Mst::DocomoApi.first
     feature = mst_docomo_api.api_feature_configs.environment_sensor.first
     Mst::EnvironmentSensor.importApiData(feature.request_api(:get,{"APIKEY" => mst_docomo_api.api_key}.merge(params)))
  end

  def self.import_environment_data(mst_environment_sensor, options = {})
  	params = {datetime_from: 1.month.ago.strftime("%Y-%m-%d"), datetime_to: Time.current.strftime("%Y-%m-%d"), data_type: DATA_TYPE[:ultraviolet], limit: "100,0"}.merge(options)
    mst_docomo_api = Mst::DocomoApi.first
    feature = mst_docomo_api.api_feature_configs.environment_data.first
    data = feature.request_api(:get,{"APIKEY" => mst_docomo_api.api_key, sensor: mst_environment_sensor.sensor_id}.merge(params))
    EnvironmentData.import_data(mst_environment_sensor, data)
    mst_environment_sensor.reload
  end

  def self.request_torendo(word)
    api = Mst::DocomoApi.first
    feature = api.api_feature_configs.torendo.first
    data = feature.request_api(:get,{"APIKEY" => api.api_key, keyword: word.to_s, lang: :ja, format: feature.request_format, s: 1, n: 50})
  end
end
