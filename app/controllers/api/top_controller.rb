# coding: utf-8
class Api::TopController < Api::BaseController
  before_action :load_mst_company

  def asahi
    @positive_article = @company.articles.order("score DESC, post_at DESC").first
    @negative_article = @company.articles.order("score ASC, post_at DESC").first
  end

  def company_detail
    @price = @company.prices.order("reported_at DESC").first
    @vector = @company.vector
  end

  def social
    @positive_comment = @company.tweets.order("score DESC, post_at DESC").first
    @negative_comment = @company.tweets.order("score ASC, post_at DESC").first
  end

  private
  def load_mst_company
    @company = Morpheme.search_nearest_company(URI.decode(params[:q].to_s))
  end
end
