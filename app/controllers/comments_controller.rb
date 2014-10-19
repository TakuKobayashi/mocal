# coding: utf-8
class CommentsController < BaseController
  before_filter :load_user

  def new
    @comment = @user.comments.new
  end

  def input
    @comment = @user.comments.find_or_create_by(token: params[:token])
    @sentence = @comment.sentences.new(user_id: @user.id, origin_sentence: params[:sentence], language_code: params[:language_code])
    @sentence.status = :initialize
    @sentence.save!
    @sentence.analyze!
  end

  private
  def load_user
    @user = User.where(name: "iii",auth_token: "aaa").first_or_create
    redirect_to root_url if @user.blank?
  end
end
