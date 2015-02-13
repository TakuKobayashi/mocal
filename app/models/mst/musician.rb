# == Schema Information
#
# Table name: mst_musicians
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  image_url  :string(255)
#  client_id  :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_mst_musicians_on_client_id  (client_id)
#

class Mst::Musician < ActiveRecord::Base
end
