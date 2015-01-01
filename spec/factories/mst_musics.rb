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

FactoryGirl.define do
  factory :mst_music, :class => 'Mst::Music' do
    
  end

end
