# == Schema Information
#
# Table name: morphological_analyses
#
#  id            :integer          not null, primary key
#  sentence_id   :integer          not null
#  dependency_id :integer          not null
#  surface       :string(255)      not null
#  reading       :string(255)
#  pos           :string(255)      not null
#  baseform      :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#
# Indexes
#
#  index_morphological_analyses_on_pos                            (pos)
#  index_morphological_analyses_on_sentence_id_and_dependency_id  (sentence_id,dependency_id)
#  index_morphological_analyses_on_surface                        (surface)
#

class MorphologicalAnalysis < ActiveRecord::Base
  belongs_to :sentence
end
