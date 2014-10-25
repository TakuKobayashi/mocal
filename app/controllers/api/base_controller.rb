# coding: utf-8
class Api::BaseController < BaseController
  include Api::ErrorHandling

  skip_before_action :verify_authenticity_token
  before_action :authentication

  private
  def authentication
    @user = User.where(auth_token: params[:auth_token]).first
    raise AuthenticationError "authenticate failed" and return false if @user.blank?
  end
end
