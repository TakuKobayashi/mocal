# == Schema Information
#
# Table name: mst_music_moods
#
#  id           :integer          not null, primary key
#  mst_music_id :integer          not null
#  start_time   :float(24)        default(0.0), not null
#  end_time     :float(24)        default(0.0), not null
#  created_at   :datetime
#  updated_at   :datetime
#
# Indexes
#
#  index_mst_music_moods_on_mst_music_id  (mst_music_id)
#

class Mst::MusicMood < ActiveRecord::Base
  belongs_to :music, class_name: "Mst::Music", foreign_key: "mst_music_id"
  has_many  :mst_music_tags, as: :source
end
