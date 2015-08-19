# == Schema Information
#
# Table name: sounds
#
#  id                :integer          not null, primary key
#  wav_file_path     :string(255)      not null
#  file_type         :string(255)      not null
#  original_name     :string(255)      not null
#  millisecond_time  :integer          default(0), not null
#  options           :text
#  created_at        :datetime
#  updated_at        :datetime
#  channel           :integer          default(0), not null
#  format            :string(255)      not null
#  bits_per_sample   :integer          default(0), not null
#  sample_rate       :integer          default(0), not null
#  total_frame_count :integer          default(0), not null
#  byte_rate         :integer          default(0), not null
#
# Indexes
#
#  index_sounds_on_original_name  (original_name)
#

class Sound < ActiveRecord::Base
  def update_info!(wav_file_path:, file_type:)
    wavefile = WaveFile::Reader.new(wav_file_path)
    duration = wavefile.total_duration
    format = wavefile.format
    update!(
      wav_file_path: wav_file_path,
      file_type: file_type,
      millisecond_time: ((duration.seconds.to_i + duration.minutes.minutes.to_i + duration.hours.hours.to_i) * 1000 + duration.milliseconds),
      channel: format.channels,
      format: format.sample_format,
      bits_per_sample: format.bits_per_sample,
      sample_rate: format.sample_rate,
      total_frame_count: duration.sample_frame_count,
      byte_rate: format.byte_rate
    )
  end

  def file_read
    return WaveFile::Reader.new(wav_file_path)
  end
end
