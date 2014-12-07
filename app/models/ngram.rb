class Ngram < ActiveRecord::Base
  has_many :ngram_relations
  has_many :articles, through: :ngram_relations, source: :source, source_type: 'Article'

  def self.split_word(word, n)
    characters = word.split(//u)
    return [word] if characters.size <= n
    return characters.each_cons(n).map(&:join)
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
