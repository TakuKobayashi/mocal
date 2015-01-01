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

require 'rails_helper'

RSpec.describe Mst::MusicAlbum, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
