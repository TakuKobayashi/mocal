class JsonConverterController < ApplicationController
  def index
  	render :layout => false
  end

  def convert
    upload_file = params[:upload_file]
    converter = JsonConverter.new(upload_file)
    json = converter.convert
    render json: json
  end
end
