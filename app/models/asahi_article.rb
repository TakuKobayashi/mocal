# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  score      :float(24)        default(0.0), not null
#  type       :string(255)      not null
#  body       :text(16777215)
#  title      :string(255)
#  post_at    :datetime
#  category   :integer
#  data_id    :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_articles_on_data_id  (data_id)
#  index_articles_on_post_at  (post_at)
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
        next if hash.compact.blank?
        article = AsahiArticle.find_or_initialize_by(data_id: hash["data_id"])
        if article.new_record?
          article.attributes = hash.merge(type: "AsahiArticle")
          article.save!
          article.split_sentences!
          if article.title.blank?
            article.update!(title: article.sentences.first.try(:body).to_s)
          end
          #article.analize!
        end
        article.make_company_relation!(crawl_log.data_id)
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
