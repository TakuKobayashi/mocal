# == Schema Information
#
# Table name: crawl_logs
#
#  id         :integer          not null, primary key
#  data_type  :string(255)      not null
#  data_id    :integer          not null
#  crawl_at   :datetime         not null
#  page_num   :integer          default(0), not null
#  status     :integer          not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_crawl_logs_on_crawl_at               (crawl_at)
#  index_crawl_logs_on_data_type_and_data_id  (data_type,data_id)
#

FactoryGirl.define do
  factory :crawl_log do
    
  end

end
