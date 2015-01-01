# == Schema Information
#
# Table name: mst_musics
#
#  id              :integer          not null, primary key
#  gn_id           :string(255)      not null
#  mst_musician_id :integer
#  title           :string(255)
#  release_date    :datetime
#  created_at      :datetime
#  updated_at      :datetime
#
# Indexes
#
#  index_mst_musics_on_gn_id            (gn_id)
#  index_mst_musics_on_mst_musician_id  (mst_musician_id)
#  index_mst_musics_on_release_date     (release_date)
#

class Mst::Music < ActiveRecord::Base
  belongs_to :musician, class_name: "Mst::Musician", foreign_key: "mst_musician_id"
  has_many  :mst_music_tags, as: :source
  has_one  :meta, class_name: "Mst::MusicBeat", foreign_key: "mst_music_id"
  has_many :beats, class_name: "Mst::MusicBeat", foreign_key: "mst_music_id"
  has_many :moods, class_name: "Mst::MusicMood", foreign_key: "mst_music_id"

  has_many :mst_music_relations
  has_many :albums, through: :mst_music_relations, source: :source, source_type: 'Mst::MusicAlbum'
end
