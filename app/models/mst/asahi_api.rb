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
  def self.request_article(word)
    api = Mst::AsahiApi.first
    feature = api.api_feature_configs.article.first
    data = feature.request_api(:post,{ackey: api.api_key, q: "Body:" + word.to_s})
  end

  def self.generate_articles!(word)
    article = Article.new
    article.generate!
    article.analize!
  end
end
