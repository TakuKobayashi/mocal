# == Schema Information
#
# Table name: mst_companies
#
#  id            :integer          not null, primary key
#  name          :string(255)      not null
#  category_code :integer          not null
#  stock_code    :integer          not null
#  search_name   :string(255)      not null
#  created_at    :datetime
#  updated_at    :datetime
#

class Mst::Company < ActiveRecord::Base

  has_many :prices, foreign_key: :mst_company_id
  has_many :company_source_relations, foreign_key: :mst_company_id
  has_many :sentences, through: :articles, source: :sentences
  has_many :articles, through: :company_source_relations, source: :source, source_type: 'Article'
  has_many :asahi_articles, through: :company_source_relations, source: :source, source_type: 'Article', class_name: 'AsahiArticle'
  has_many :tweets, through: :company_source_relations, source: :source, source_type: 'Tweet'

  has_one  :crawl_log, as: :data
  has_many :phrase_relations, as: :source
  has_many :dependencies, through: :phrase_relations, source: :dependency
  has_many :morphemes, through: :phrase_relations, source: :morpheme
  has_many :ngram_relations, as: :source
  has_many :ngrams, through: :ngram_relations, source: :ngram

  # == Asahi Functions

  def vector
    prices = self.prices.order("reported_at DESC").limit(5).reverse
    return linner_least_squares(prices)
  end

  def positive_words
    sentence_ids = self.sentences.pluck(:id)
    word_scores = WordScore.where(sentence_id: sentence_ids).group(:word).order("sum_score DESC").limit(5).sum(:score)
    return word_scores.keys
  end

  def negative_words
    sentence_ids = self.sentences.pluck(:id)
    word_scores = WordScore.where(sentence_id: sentence_ids).group(:word).order("sum_score ASC").limit(5).sum(:score)
    return word_scores.keys
  end

  def emotion_graphs
    articles = self.articles.order("post_at DESC").includes(:sentences).limit(20).reverse
    if articles.blank?
      return [0,0,0]
    else
      sentences = Sentence.where(source_type: "Article", source_id: articles.map(&:id))
      pos_sums = sentences.where("score > 0").group([:source_type, :source_id]).sum(:score)
      neg_sums = sentences.where("score < 0").group([:source_type, :source_id]).sum(:score)
      emotion_graphs = articles.map do |article|
        [article.post_at.strftime("%Y%m%d"), pos_sums[[article.class.base_class.to_s,article.id]].to_i, neg_sums[[article.class.base_class.to_s,article.id]].to_i]
      end
      return emotion_graphs
    end
  end

  def social_trend
    {
      :positive => self.tweets.where("score > 0").sum(:score),
      :negative => self.tweets.where("score < 0").sum(:score)
    }
  end

  # == Private Functions

  private
  def linner_least_squares(prices)
    a = b = c = d = 0.0
    prices.each_with_index do |price, x|
      y = price.price
      a += x*y
      b += x
      c += y
      d += x**2
    end
    n = prices.size
    dydx = (n*a-b*c)/(n*d-b**2)
    dy = (d*c-a*b)/(n*d-b**2)
    if dydx > 0
      1
    elsif dydx == 0
      0
    else
      -1
    end
  end

end
