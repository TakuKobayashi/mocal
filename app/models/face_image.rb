# == Schema Information
#
# Table name: face_images
#
#  id            :integer          not null, primary key
#  image_path    :string(255)      not null
#  source_url    :string(255)
#  keyword       :string(255)
#  tag           :string(255)
#  original_name :string(255)      not null
#  created_at    :datetime
#  updated_at    :datetime
#
# Indexes
#
#  index_face_images_on_image_path  (image_path)
#  index_face_images_on_tag         (tag)
#

class FaceImage < ActiveRecord::Base
  has_many :face_image_infos
end
