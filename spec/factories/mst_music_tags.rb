# == Schema Information
#
# Table name: mst_music_tags
#
#  id          :integer          not null, primary key
#  source_type :string(255)      not null
#  source_id   :integer          not null
#  key         :string(255)      not null
#  value       :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#
# Indexes
#
#  index_mst_music_tags_on_key                        (key)
#  index_mst_music_tags_on_source_type_and_source_id  (source_type,source_id)
#  index_mst_music_tags_on_value                      (value)
#

FactoryGirl.define do
  factory :mst_music_tag, :class => 'Mst::MusicTag' do
    
  end

end
