# == Schema Information
#
# Table name: morphological_analyses
#
#  id            :integer          not null, primary key
#  sentence_id   :integer          not null
#  dependency_id :integer
#  word          :string(255)      not null
#  pos           :string(255)      not null
#  created_at    :datetime
#  updated_at    :datetime
#
# Indexes
#
#  index_morphological_analyses_on_pos                            (pos)
#  index_morphological_analyses_on_sentence_id_and_dependency_id  (sentence_id,dependency_id)
#

require 'rails_helper'

RSpec.describe MorphologicalAnalysis, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
