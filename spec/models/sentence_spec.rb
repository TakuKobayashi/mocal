# == Schema Information
#
# Table name: sentences
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  source_type      :string(255)      not null
#  source_id        :integer          not null
#  origin_sentence  :text
#  fixture_sentence :text
#  status           :integer          not null
#  language_code    :string(255)      not null
#  created_at       :datetime
#  updated_at       :datetime
#
# Indexes
#
#  index_sentences_on_source_type_and_source_id  (source_type,source_id)
#  index_sentences_on_status                     (status)
#  index_sentences_on_user_id                    (user_id)
#

require 'rails_helper'

RSpec.describe Sentence, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
