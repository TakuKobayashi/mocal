# == Schema Information
#
# Table name: dependencies
#
#  id          :integer          not null, primary key
#  sentence_id :integer          not null
#  word        :string(255)      not null
#  score       :float(24)        default(0.0), not null
#  created_at  :datetime
#  updated_at  :datetime
#
# Indexes
#
#  index_dependencies_on_sentence_id  (sentence_id)
#

class Dependency < ActiveRecord::Base
  belongs_to :sentence
end
