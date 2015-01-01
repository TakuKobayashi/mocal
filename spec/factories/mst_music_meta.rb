# == Schema Information
#
# Table name: mst_music_meta
#
#  id           :integer          not null, primary key
#  mst_music_id :integer          not null
#  bpm          :float(24)
#  playing_time :float(24)        default(0.0), not null
#  file_path    :string(255)      not null
#  created_at   :datetime
#  updated_at   :datetime
#
# Indexes
#
#  index_mst_music_meta_on_mst_music_id  (mst_music_id)
#

FactoryGirl.define do
  factory :mst_music_metum, :class => 'Mst::MusicMeta' do
    
  end

end
