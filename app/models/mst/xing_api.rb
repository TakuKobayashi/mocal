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

class Mst::XingApi < Mst::ApiConfig
  def self.request_text_analize_api(text)
    api = Mst::XingApi.first
    feature = api.api_feature_configs.morphological_analysis.first
    data = feature.request_api(:get,{acckey: api.api_key, sent: text})
  end
end
