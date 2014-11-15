# coding: utf-8
class Api::BaseController < BaseController
  include Api::ErrorHandling
  skip_before_action :verify_authenticity_token

end
