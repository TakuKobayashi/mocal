# == Schema Information
#
# Table name: ngrams
#
#  id         :integer          not null, primary key
#  word       :string(255)      not null
#  counter    :integer          default(0), not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_ngrams_on_word  (word)
#

require 'rails_helper'

RSpec.describe Ngram, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
