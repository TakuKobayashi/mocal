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

  def self.import_senser_location
     mst_docomo_api = Mst::DocomoApi.first
     feature = mst_docomo_api.api_feature_configs.environment_sensor.first
     Mst::EnvironmentSensor.importApiData(feature.request_api(:get,{"APIKEY" => mst_docomo_api.api_key, with_data: true, data_type: DATA_TYPE[:ultraviolet], limit: "1000,0"}))
  end

  def self.import_environment_data(data_type, mst_environment_sensor, datetime_from = 1.month.ago)
    mst_docomo_api = Mst::DocomoApi.first
    feature = mst_docomo_api.api_feature_configs.environment_data.first
    data = feature.request_api(:get,{"APIKEY" => mst_docomo_api.api_key, sensor: mst_environment_sensor.sensor_id, datetime_from: datetime_from.strftime("%Y-%m-%d"), datetime_to: Time.current.strftime("%Y-%m-%d"), data_type: data_type, limit: "1000,0"})
    EnvironmentData.import_data(mst_environment_sensor, data)
    mst_environment_sensor.reload
  end
end
