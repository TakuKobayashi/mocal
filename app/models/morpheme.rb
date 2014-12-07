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
  has_many :mst_companies, through: :phrase_relations, source: :source, source_type: 'Mst::Company'

  scope :search_word, ->(word){
     search_words = (2..word.size).to_a.map do |i|
       Ngram.split_word(word, i)
     end.flatten
     search_words = [word] if search_words.blank?
     where(word: search_words)
  }

  def self.search_nearest_company(word)
    morphemes = Morpheme.search_word(word).includes(:mst_companies)
    mst_companies = morphemes.map{|morpheme| morpheme.mst_companies }.flatten.uniq
    mst_company = mst_companies.select{|mst_company| mst_company.name.include?(word) }.min_by{|mst_company| (mst_company.name.size - word.size).abs }
    return mst_company
  end
end
