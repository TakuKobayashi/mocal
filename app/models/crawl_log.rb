# == Schema Information
#
# Table name: crawl_logs
#
#  id                   :integer          not null, primary key
#  data_type            :string(255)      not null
#  data_id              :integer          not null
#  crawl_at             :datetime         not null
#  current_crawl_number :integer          default(1), not null
#  max_crawl_number     :integer
#  status               :integer          not null
#  created_at           :datetime
#  updated_at           :datetime
#
# Indexes
#
#  index_crawl_logs_on_crawl_at               (crawl_at)
#  index_crawl_logs_on_data_type_and_data_id  (data_type,data_id)
#  index_crawl_logs_on_status                 (status)
#

class CrawlLog < ActiveRecord::Base
  enum status: [
    :stanby,
    :crawling,
    :remain,
    :complete,
  ]

  belongs_to :data, :polymorphic => true

  def self.search_target(model)
    if model.kind_of?(ActiveRecord::Base)
      class_name = model.class.to_s
    else
      class_name = model.to_s
    end
    #クローリングできるものがあるならそれを返す
    targets = CrawlLog.where(data_type: class_name)
    not_complete = targets.where.not(status: CrawlLog.statuses["complete"]).first
    return not_complete if not_complete.present?

    #打ち止めなら最後にクローリングしたもの
    m = class_name.constantize
    last_model = m.last
    last_target = targets.where(data_id: last_model.id).first
    return targets.order("crawl_at ASC").first if last_target.present?

    #どれもなかったら新しいものを作って返す
    max_id = targets.maximum(:data_id)
    next_model = m.where("id > ?", max_id.to_i).first
    return CrawlLog.create(data: next_model, status: :stanby, crawl_at: Time.current)
  end
end
