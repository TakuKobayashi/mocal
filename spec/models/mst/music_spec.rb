# == Schema Information
#
# Table name: mst_musics
#
#  id              :integer          not null, primary key
#  gn_id           :string(255)
#  mst_musician_id :integer
#  title           :string(255)
#  release_date    :datetime
#  duration        :integer          default(0), not null
#  client_id       :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#
# Indexes
#
#  index_mst_musics_on_client_id        (client_id)
#  index_mst_musics_on_duration         (duration)
#  index_mst_musics_on_gn_id            (gn_id)
#  index_mst_musics_on_mst_musician_id  (mst_musician_id)
#  index_mst_musics_on_release_date     (release_date)
#

require 'rails_helper'

RSpec.describe Mst::Music, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
