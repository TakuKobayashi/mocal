# == Schema Information
#
# Table name: mst_companies
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class Mst::Company < ActiveRecord::Base

  def positiveArticle
    {
      :title => "記事名",
      :body => "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aperiam, et cupiditate ipsum unde modi? Perspiciatis earum aperiam maiores rem modi ipsam, ratione velit odio laborum alias, beatae veritatis a accusantium."
    }
  end

  def negativeArticle
    {
      :title => "記事名",
      :body => "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aperiam, et cupiditate ipsum unde modi? Perspiciatis earum aperiam maiores rem modi ipsam, ratione velit odio laborum alias, beatae veritatis a accusantium."
    }
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

  def positiveComment
    	{
        :body => "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Voluptate assumenda dicta placeat corrupti vero dolorum, non saepe eum tenetur facilis asperiores, enim incidunt aut autem officiis laborum fuga, maxime nihil!",
	      :score => 0
      }
  end

  def negativeComment
    {
      :body => "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Voluptate assumenda dicta placeat corrupti vero dolorum, non saepe eum tenetur facilis asperiores, enim incidunt aut autem officiis laborum fuga, maxime nihil!",
      :score => 0
    }
  end

  def socialTrend
    {
	     :positive => 0000,
	     :negative => 0000
	  }
  end

end
