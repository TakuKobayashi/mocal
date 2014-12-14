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

class Ngram < ActiveRecord::Base
  has_many :ngram_relations
  has_many :articles, through: :ngram_relations, source: :source, source_type: 'Article'
  has_many :mst_companies, through: :ngram_relations, source: :source, source_type: 'Mst::Company'

  scope :search_word, ->(word){
     search_words = Ngram.split_word(word, 2)
     if search_words.blank? || word.size <= 1
       where("word like '#{word}%'")
     else
       where(word: search_words)
     end
  }

  def self.split_word(word, n)
    characters = word.split(//u)
    return [word] if characters.size <= n
    return characters.each_cons(n).map(&:join)
  end

  def self.search_nearest_company(word)
    ngrams = Ngram.search_word(word).includes(:mst_companies)
    mst_companies = ngrams.map{|ngram| ngram.mst_companies }.flatten.uniq
    mst_company = mst_companies.select{|mst_company| mst_company.name.include?(word) }.min_by{|mst_company| (mst_company.name.size - word.size).abs }
    return mst_company
  end

  def self.generates(instance, word, i = 2)
    words = Ngram.split_word(word, i).uniq
    ngrams = Ngram.where(word: words)
    exists_words, new_words = words.partition{|word| ngrams.any?{|ngram| ngram.word == word} }
    array = []
    new_words.each do |w|
      array << Ngram.new(word: w, counter: 1)
    end
    Ngram.import(array) if array.present?
    Ngram.where(word: exists_words).update_all("counter = counter + 1") if exists_words.present?
    array = []
    ids = Ngram.where(word: exists_words).pluck(:id)
    ids.each do |id|
      array << NgramRelation.new(source: instance, ngram_id: id)
    end
    NgramRelation.import(array)
  end
end
