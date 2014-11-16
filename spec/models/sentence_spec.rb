# == Schema Information
#
# Table name: sentences
#
#  id             :integer          not null, primary key
#  article_id     :integer          not null
#  mst_company_id :integer
#  body           :text
#  score          :float(24)        default(0.0), not null
#  created_at     :datetime
#  updated_at     :datetime
#
# Indexes
#
#  index_sentences_on_article_id      (article_id)
#  index_sentences_on_mst_company_id  (mst_company_id)
#

require 'rails_helper'

RSpec.describe Sentence, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
