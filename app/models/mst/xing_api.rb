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
  LIMIT_SENDABLE_SENTENCES = 50

  def self.request_text_analize_api(text)
    api = Mst::XingApi.first
    feature = api.api_feature_configs.morphological_analysis.first
    data = feature.request_api(:post,{acckey: api.api_key, sent: text})
    return [] if data["apierr"].to_i != 0
    arrays = data["results"].map do |cell|
      next if cell["err"].to_i != 0
      hash = {}
      morphemes = cell["morphemes"].group_by{|m| m["pid"] }
      hash["dependencies"] = morphemes.map do |pid, values|
        h = {}
        h["morphemes"] = values.map do |m|
          next if m["err"].to_i != 0
          {"word" => m["gokan"], "pos" => m["hinshi"]}
        end
        phrase = cell["phrases"].detect{|phrase| phrase["pid"] == pid }
        h["score"] = WordScore::SCORE_LIST[phrase["ppn"].to_i]
        h
      end
      hash["score"] = Sentence::SCORE_LIST[cell["spn"].to_i]
      hash
    end.compact
    arrays
  end
end
