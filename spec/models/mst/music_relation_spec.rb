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

require 'rails_helper'

RSpec.describe Mst::MusicRelation, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
