# coding: utf-8
class Api::EnvironmentController < Api::BaseController
  skip_before_action :authentication

  def ulterviolet
  	raise BadRequest if params[:lat].blank? || params[:lon].blank?
    @mst_enviroment_sensor = Mst::EnvironmentSensor.nearest_sensor(params[:lat].to_f, params[:lon].to_f)
    Mst::DocomoApi.import_environment_data(Mst::DocomoApi::DATA_TYPE[:ultraviolet], @mst_enviroment_sensor)
    @mst_enviroment_sensor.reload
    @data = @mst_enviroment_sensor.environment_data.order("obs_datetime DESC").first
  end
end