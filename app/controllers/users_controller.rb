# coding: utf-8
class UsersController < BaseController
  skip_before_filter :verify_authenticity_token

  def create_device
    User.transaction do
      @device = AndroidDevice.where(mac_address: params[:auth_token]).first_or_initialize
      if @device.user.present?
        @user = @device.user
      else
        #送られるパラメータは長い+頻繁に使いたくないので適当に作ることにする
        @user = User.new(auth_token: SecureRandom.hex)
      end
      @user.name = params[:name].to_s
      @user.save!
      # TODO 以下はAndroid専用処理
      @device.user_id = @user.id
      @device.device_type = @device.class.to_s
      @device.save!
    end
  end
end
