# == Schema Information
#
# Table name: mst_music_albums
#
#  id                :integer          not null, primary key
#  gn_id             :string(255)      not null
#  mst_musician_id   :integer
#  title             :string(255)
#  jacket_image_path :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#
# Indexes
#
#  index_mst_music_albums_on_gn_id            (gn_id)
#  index_mst_music_albums_on_mst_musician_id  (mst_musician_id)
#

class Mst::MusicAlbum < ActiveRecord::Base
  belongs_to :musician, class_name: "Mst::Musician", foreign_key: "mst_musician_id"
  has_many :mst_music_relations, as: :source
  has_many :musics, through: :mst_music_relations, source: :music
end
