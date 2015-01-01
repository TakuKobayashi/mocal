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

class Mst::MusicRelation < ActiveRecord::Base
  belongs_to :music, class_name: "Mst::Music", foreign_key: "mst_music_id"
  belongs_to :source, :polymorphic => true
end
