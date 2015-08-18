class Api::SoundController < Api::BaseController
  def upload
    upload_file = params[:upload_file]
    if upload_file.present?
      name = upload_file.original_filename.underscore
      original_path = Rails.root.to_s + "/tmp/sound/original/#{name}"
      ext = File.extname(name)
      save_path = Rails.root.to_s + "/tmp/sound/wav/" + File.basename(name, '.*') + ".wav"
      @sound = Sound.find_or_initialize_by(original_name: name)
      if @sound.new_record?
        #save file
        file = File.open(original_path, 'wb') { |f| f.write(upload_file.read) }
        FFMPEG.ffmpeg_binary = Rails.root.to_s + "/tmp/ffmpeg/ffmpeg -f #{ext[1..ext.size]}" # 適当なところに置いたffmpegバイナリ実行ファイルのパス
        ffmpeg = FFMPEG::Movie.new(original_path)
        ffmpeg.transcode(save_path)
      end
      @sound.update_info!(wav_file_path: save_path, file_type: ext)
    end
  end

  def stream
  end

  def wave
  end

  def fft
  end

  def vocal_canseler
  end
end
