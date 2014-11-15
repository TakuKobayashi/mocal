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
  def self.request_torendo(word)
    api = Mst::DocomoApi.first
    feature = api.api_feature_configs.torendo.first
    data = feature.request_api(:get,{"APIKEY" => api.api_key, keyword: word.to_s, lang: :ja, format: feature.request_format, s: 1, n: 50})
  end
end
