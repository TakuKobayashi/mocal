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

class Mst::AsahiApi < Mst::ApiConfig
  def self.request_article(word, option = {})
    api = Mst::AsahiApi.first
    feature = api.api_feature_configs.article.first
    data = feature.request_api(:post, option.merge!(ackey: api.api_key, q: "Body:" + word.to_s))
    puts data
    return [] if data.blank? || data["response"].blank? || data["response"]["result"].blank? || data["response"]["result"]["doc"].blank?
    result = {}
    result["numFound"] = data["response"]["result"]["numFound"].to_i
    result["articles"] = data["response"]["result"]["doc"].map do |doc|
      hash = {}
      doc.each do |k, v|
        key = k.to_s.underscore
        if ["id", "category", "body", "title", "release_date"].include?(key)
          if key == "release_date"
            hash["post_at"] = v
          elsif key == "id"
            hash["data_id"] = v
          elsif key == "category"
            hash["category"] = Article::CATEGORY[v]
          else
            hash[key] = v
          end
        end
      end
      hash
    end
    result
  end
end
