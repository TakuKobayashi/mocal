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

  has_many :prices, -> {order(reported_at: :desc)}, foreign_key: :mst_company_id
  has_many :company_source_relations, foreign_key: :mst_company_id
  has_many :sentences, through: :company_source_relations, source: :source, source_type: 'Sentence'
  has_many :articles, through: :company_source_relations, source: :source, source_type: 'Article'

  has_one  :crawl_log, as: :data
  has_many :phrase_relations, as: :source

  # == Asahi Functions

  def positiveArticle
    paper_articles = self.articles.where(:type => "NewsPaper")
    if paper_articles.length == 0
      Article.new()
    else
      paper_articles.max_by do |article|
        article.score
      end
    end
  end

  def negativeArticle
    paper_articles = self.articles.where(:type => "NewsPaper")
    if paper_articles.length == 0
      Article.new()
    else
      paper_articles.min_by do |article|
        article.score
      end
    end
  end

  def vector
    array = [(0..4), self.prices.limit(5).reverse]
    linner_least_squares(array)
  end

  def positiveWord
    ["ワード1","ワード2","ワード3","ワード4","ワード5"]
  end

  def negativeWord
    ["ワード1","ワード2","ワード3","ワード4","ワード5"]
  end

  def emotionGraph
    articles = self.articles.where(:type => "NewsPaper").limit(20).reverse
    if articles.length == 0
      [0,0,0]
    else
      articles.map do |article|
        pos_sum = article.sentences.inject {|sum, sentence| sum + (sentence.score>0) ? sentence.score : 0 }
        neg_sum = article.sentences.inject {|sum, sentence| sum + (sentence.score<0) ? sentence.score : 0 }
        [article.post_at.strftime("%Y%m%d"), pos_sum, neg_sum]
      end
    end
  end

  # == Social Functions

  def positiveComment
    tweets = self.articles.where(:type => "Tweet")
    if tweets.length == 0
      Article.new()
    else
      tweets.max_by do |article|
        article.score
      end
    end
  end

  def negativeComment
    tweets = self.articles.where(:type => "Tweet")
    if tweets.length == 0
      Article.new()
    else
      tweets.min_by do |article|
        article.score
      end
    end
  end

  def socialTrend
    positive_score = 0
    negative_score = 0
    self.articles.map do |article|
      if article.score > 0
        positive_score += article.score
      else
        negative_score += article.score
      end
    end
    {
      :positive => positive_score,
      :negative => negative_score
    }
  end

  # == Private Functions

  private
  def linner_least_squares(matrix)
    a = b = c = d = 0.0
    matrix[0].each_with_index do |x,i|
      y = matrix[1][i].price
      a += x*y
      b += x
      c += y
      d += x**2
    end
    n = matrix[0].size
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
