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

require 'rails_helper'

RSpec.describe Mst::MusicBeat, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
