# == Schema Information
#
# Table name: mst_musicians
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  image_url  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Mst::Musician < ActiveRecord::Base
end
