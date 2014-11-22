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
  def self.crawl
    crawl_log = CrawlLog.search_target(Mst::Company)
    #クローリング中ならこの後の処理はやらない
    return if crawl_log.crawling?
    crawl_log.crawling!
    start = crawl_log.current_crawl_number
    data = Mst::AsahiApi.request_article(crawl_log.data.search_name, {rows: 50, start: start})
    AsahiArticle.transaction do
      data["articles"].each do |hash|
        next if AsahiArticle.exists?(data_id: hash["data_id"])
        article = AsahiArticle.create(hash.merge(type: "AsahiArticle", mst_company_id: crawl_log.data_id))
        article.split_sentences!
        if article.title.blank?
          article.update!(title: article.sentences.first.try(:body).to_s)
        end
        article.analize!
      end
      start += data["articles"].length
      crawl_log.max_crawl_number = data["numFound"].to_i
      if start >= crawl_log.max_crawl_number
        crawl_log.status = :complete
      else
        crawl_log.current_crawl_number = start
        crawl_log.status = :remain
      end
      crawl_log.crawl_at = Time.current
      crawl_log.save!
    end

    rescue => e
    crawl_log.stanby!
    puts e.message
  end
end
