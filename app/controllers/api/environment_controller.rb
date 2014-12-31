# coding: utf-8
class Api::EnvironmentController < Api::BaseController
  skip_before_action :authentication

  def ulterviolet
    raise BadRequest if params[:lat].blank? || params[:lon].blank?
    @mst_enviroment_sensor = Mst::EnvironmentSensor.nearest_sensor(params[:lat].to_f, params[:lon].to_f)
    @mst_enviroment_sensor.location_request_logs.create(latitude: params[:lat].to_f, longitude: params[:lon].to_f, ip_address: request.remote_ip)
    Mst::DocomoApi.import_environment_data(@mst_enviroment_sensor)
    @mst_enviroment_sensor.reload
    @today_data = @mst_enviroment_sensor.environment_data.order("obs_datetime DESC").first
    @tommorrow_data = @mst_enviroment_sensor.environment_data.where("obs_datetime >= ?", 1.month.ago).average(:val)
  end
end