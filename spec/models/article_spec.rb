# == Schema Information
#
# Table name: articles
#
#  id             :integer          not null, primary key
#  mst_company_id :integer          not null
#  type           :string(255)      not null
#  score          :float(24)        default(0.0), not null
#  body           :text
#  title          :string(255)
#  post_at        :datetime
#  category       :integer
#  created_at     :datetime
#  updated_at     :datetime
#
# Indexes
#
#  index_articles_on_mst_company_id  (mst_company_id)
#  index_articles_on_post_at         (post_at)
#  index_articles_on_type            (type)
#

require 'rails_helper'

RSpec.describe Article, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
