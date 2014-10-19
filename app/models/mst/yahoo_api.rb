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

class Mst::YahooApi < Mst::ApiConfig
  def self.request_text_analize_api(text)
    result = {}
    api_config = Mst::ApiConfig.where(type: "Mst::YahooApi").first
    api_config.api_feature_configs.each do |feature_config|
      hash = feature_config.request_api(:post, {sentence: text, appid: api_config.api_key})
      result[feature_config.api_tag] = api_config.send(feature_config.api_tag , hash)
      log = feature_config.api_use_logs.first_or_initialize
      if log.last_used_at.blank? || log.last_used_at.beginning_of_day < Time.current.beginning_of_day
        log.last_used_at = 0
      end
      log.last_used_at = Time.current
      log.use_count += 1
      log.save!
    end
    return result
  end

  def dependency(xml_hash)
    p xml_hash
    array = xml_hash["ResultSet"]["Result"]["ChunkList"]["Chunk"]
    r = [array].flatten.map do |hash|
      [hash["MorphemList"]["Morphem"]].flatten.map do |h|
      	result = {}
      	h.each do |k, v|
      	  result[k.underscore] = v
      	end
        result
      end
    end
    return r
  end

  def key_phrase(xml_hash)
    array = xml_hash["ResultSet"]["Result"]
    r = [array].flatten.map.each do |hash|
      result = {}
      hash.each do |k, v|
        result[k.underscore] = v
      end
      result
    end
    return r

  end

  def fixture_sentence(xml_hash)
    array = xml_hash["ResultSet"]["Result"]
    r = [array].flatten.map.each do |hash|
      result = {}
      hash.each do |k, v|
        result[k.underscore] = v
      end
      result
    end
    return r
  end
end
