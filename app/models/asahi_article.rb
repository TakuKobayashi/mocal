# == Schema Information
#
# Table name: articles
#
#  id             :integer          not null, primary key
#  mst_company_id :integer          not null
#  score          :float(24)        default(0.0), not null
#  type           :string(255)      not null
#  body           :text
#  title          :string(255)
#  post_at        :datetime
#  category       :integer
#  data_id        :string(255)      not null
#  created_at     :datetime
#  updated_at     :datetime
#
# Indexes
#
#  index_articles_on_data_id         (data_id)
#  index_articles_on_mst_company_id  (mst_company_id)
#  index_articles_on_post_at         (post_at)
#

class AsahiArticle < Article
  def self.generate(mst_company, options = {})
    data = Mst::AsahiApi.request_article(mst_company.search_name, options)
    return nil if data.blank?
    data.each do |hash|
      article = AsahiArticle.create!(hash.merge(type: "AsahiArticle", mst_company_id: mst_company.id))
      article.split_sentences!
      if article.title.blank?
        article.update!(title: article.sentences.first.try(:body).to_s)
      end
      article.analize!
    end
  end
end
