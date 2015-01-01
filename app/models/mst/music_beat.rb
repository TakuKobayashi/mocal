# == Schema Information
#
# Table name: mst_music_beats
#
#  id           :integer          not null, primary key
#  mst_music_id :integer          not null
#  timing       :float(24)        not null
#  number       :integer          default(0), not null
#  created_at   :datetime
#  updated_at   :datetime
#
# Indexes
#
#  index_mst_music_beats_on_mst_music_id  (mst_music_id)
#

class Mst::MusicBeat < ActiveRecord::Base
  belongs_to :music, class_name: "Mst::Music", foreign_key: "mst_music_id"
end
