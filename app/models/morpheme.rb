# == Schema Information
#
# Table name: morphemes
#
#  id         :integer          not null, primary key
#  word       :string(255)      not null
#  pos        :string(255)      not null
#  counter    :integer          default(0), not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_morphemes_on_pos   (pos)
#  index_morphemes_on_word  (word)
#

class Morpheme < ActiveRecord::Base
  has_many :phrase_relations
  has_many :dependencies, through: :phrase_relations, source: :dependency
end
