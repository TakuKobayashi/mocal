# == Schema Information
#
# Table name: mst_music_relations
#
#  id           :integer          not null, primary key
#  mst_music_id :integer          not null
#  source_type  :string(255)      not null
#  source_id    :integer          not null
#  created_at   :datetime
#  updated_at   :datetime
#
# Indexes
#
#  index_mst_music_relations_on_source_type_and_source_id  (source_type,source_id)
#  music_relation_index                                    (mst_music_id,source_type,source_id)
#

FactoryGirl.define do
  factory :mst_music_relation, :class => 'Mst::MusicRelation' do
    
  end

end
