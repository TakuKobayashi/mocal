# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  score      :float(24)        default(0.0), not null
#  type       :string(255)      not null
#  body       :text
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

require 'rails_helper'

RSpec.describe Article, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
