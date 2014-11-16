# == Schema Information
#
# Table name: mst_companies
#
#  id            :integer          not null, primary key
#  name          :string(255)      not null
#  category_code :integer          not null
#  stock_code    :integer          not null
#  created_at    :datetime
#  updated_at    :datetime
#

MAX_INT = 10000000
class Mst::Company < ActiveRecord::Base
  has_many :articles, foreign_key: :mst_company_id
  has_many :prices, -> {order(reported_at: :desc)}, foreign_key: :mst_company_id

# == Asahi Functions

  def positiveArticle
    self.articles.max_by do |article|
      if article.type == "NewsPaper"
        article.score
      else
        0
      end
    end
  end

  def negativeArticle
    self.articles.min_by do |article|
      if article.type == "NewsPaper"
        article.score
      else
        MAX_INT
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
    [
      [20149999,00000,00000],
      [20149999,00000,00000],
      [20149999,00000,00000],
      [20149999,00000,00000],
      [20149999,00000,00000],
      [20149999,00000,00000]
    ]
  end

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


# == Social Functions

  def positiveComment
    self.articles.max_by do |article|
      if article.type == "Tweet"
        article.score
      else
        0
      end
    end
  end

  def negativeComment
    self.articles.min_by do |article|
      if article.type == "Tweet"
        article.score
      else
        MAX_INT
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

end
