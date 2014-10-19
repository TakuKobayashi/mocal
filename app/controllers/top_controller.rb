# coding: utf-8
class TopController < BaseController
  def index
  end

  def login
    user = User.where(auth_token: params[:auth_token]).first
    session[:auth_token] = user.auth_token
    redirect_to proceeding_index_url
  end
end
