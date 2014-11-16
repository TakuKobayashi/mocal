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
    data = feature.request_api(:post,{acckey: api.api_key, sent: text})
    arrays = data["results"].map do |cell|
      hash = {}
      hash["morphological_analysis"] = cell["morphemes"].map do |m|
        nil if m["err"] == 0
        {word: m["shuushi"], pos: m["hinshi"]}
      end
      hash["morphological_analysis"].compact!
      hash["dependency"] = cell["phrases"].map do |p|
        nil if p["err"] == 0
        {score: Dependency::SCORE_LIST[p["ppn"].to_i], word: p["jshuushi"].to_s + p["fshuushi"].to_s, pos: p["jhinshi"].to_s}
      end
      hash["dependency"].compact!
      hash["score"] = cell["spn"]
      hash
    end
    arrays
  end
end
