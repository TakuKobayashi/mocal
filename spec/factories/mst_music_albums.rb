# == Schema Information
#
# Table name: mst_music_albums
#
#  id                :integer          not null, primary key
#  gn_id             :string(255)
#  mst_musician_id   :integer
#  title             :string(255)
#  jacket_image_path :string(255)
#  client_id         :string(255)      not null
#  created_at        :datetime
#  updated_at        :datetime
#
# Indexes
#
#  index_mst_music_albums_on_client_id        (client_id)
#  index_mst_music_albums_on_gn_id            (gn_id)
#  index_mst_music_albums_on_mst_musician_id  (mst_musician_id)
#

FactoryGirl.define do
  factory :mst_music_album, :class => 'Mst::MusicAlbum' do
    
  end

end
