# == Schema Information
#
# Table name: ngram_relations
#
#  id          :integer          not null, primary key
#  source_type :string(255)      not null
#  source_id   :integer          not null
#  ngram_id    :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#
# Indexes
#
#  index_ngram_relations_on_ngram_id  (ngram_id)
#  ngram_index                        (source_type,source_id,ngram_id)
#

require 'rails_helper'

RSpec.describe NgramRelation, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
