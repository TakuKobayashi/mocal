# coding: utf-8
class Api::MusicScoresController < Api::BaseController
  def create
    upload_file = params[:upload_file]
    if upload_file.present?
      name = upload_file.original_filename.underscore
      path = Rails.root.to_s + "/tmp/music/#{name}"
      #save file
      file = File.open(path, 'wb') { |f|
        f.write(upload_file.read)
      }
      data = Mst::GracenoteApi.generate_score(File.open(path))
    end
  end

  def index
  	#if already exists score, return status code 208
    head 208
  end
end
