class Api::SoundsController < Api::BaseController
  def upload
    upload_file = params[:upload_file]
    if upload_file.present?
      name = upload_file.original_filename.underscore
      original_path = Rails.root.to_s + "/tmp/sound/original/#{name}"
      ext = File.extname(name)
      save_path = Rails.root.to_s + "/tmp/sound/wav/" + File.basename(name, '.*') + ".wav"
      #save file
      file = File.open(original_path, 'wb') { |f| f.write(upload_file.read) }
      FFMPEG.ffmpeg_binary = Rails.root.to_s + "/tmp/ffmpeg -f #{ext}" # 適当なところに置いたffmpegバイナリ実行ファイルのパス
      ffmpeg = FFMPEG::Movie.new(original_path)
      ffmpeg.transcode(save_path)
    end
  end

  def play

  end

  def wave
  end

  def fft
  end

  def vocal_canseler
  end
end
