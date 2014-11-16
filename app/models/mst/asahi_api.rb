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
    array = data["response"]["result"]["doc"].map do |doc|
      hash = {}
      doc.each do |k, v|
        if ["category", "body", "title", "release_date"].include?(k.underscore)
          if k.underscore == "release_date"
            hash["post_at"] = v
          elsif k.underscore == "category"
            hash[k.underscore.to_s] = v
          else
            hash[k.underscore.to_s] = v
          end
        end
      end
      hash
    end
    array
  end

  def self.generate_articles!(mst_company)
    data = Mst::AsahiApi.request_article(mst_company.name)
    articles = data.map do |h|
      h["mst_company_id"] = mst_company.id
      h["type"] = "NewsPaper"
      article = Article.new(h)
      article.save!
      list = []
      article.body.split(/\s*(¥n|。)\s*/).each do |b|
        list << article.sentences.new(body: b)
      end
      Sentence.import(list)
      article.reload
      if article.title.blank?
        article.title = article.sentences.first.try(:body).to_s
        article.save!
      end
      article.analize!
      article
    end
    articles
  end
end
