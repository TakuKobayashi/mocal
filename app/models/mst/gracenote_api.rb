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

class Mst::GracenoteApi < Mst::ApiConfig
  def self.generate_score(file)
    api = Mst::GracenoteApi.first
    feature = api.api_feature_configs.timeline.first
    result = feature.request_api(:post, {"audiofile" => file})
    if result["features"].blank?
      feature.readonly!
      feature.request_url += result["id"]
      result.merge!(feature.request_api(:get))
    end
    return result
  end
end
