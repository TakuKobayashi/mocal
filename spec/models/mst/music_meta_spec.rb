# == Schema Information
#
# Table name: mst_music_meta
#
#  id           :integer          not null, primary key
#  mst_music_id :integer          not null
#  bpm          :float(24)
#  playing_time :float(24)        default(0.0), not null
#  file_path    :string(255)      not null
#  upload_id    :integer
#  created_at   :datetime
#  updated_at   :datetime
#
# Indexes
#
#  index_mst_music_meta_on_mst_music_id  (mst_music_id)
#  index_mst_music_meta_on_upload_id     (upload_id)
#

require 'rails_helper'

RSpec.describe Mst::MusicMeta, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
