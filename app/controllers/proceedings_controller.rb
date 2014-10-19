# coding: utf-8
class ProceedingsController < BaseController
  before_filter :load_user

  def index
    @sentences = @user.sentences.includes(:source).page(params[:page]).per(10)
  end

  def show
    
  end

  def new
  end

  def result
  end

  private
  def load_user
    @user = User.where(auth_token: session[:auth_token]).first
    redirect_to root_url if @user.blank?
  end
end
