# == Schema Information
#
# Table name: face_images
#
#  id              :integer          not null, primary key
#  image_path      :string(255)      not null
#  source_url      :string(255)
#  keyword         :string(255)
#  tag             :string(255)
#  original_name   :string(255)      not null
#  source_category :integer          not null
#  width           :integer          default(0), not null
#  height          :integer          default(0), not null
#  options         :text
#  created_at      :datetime
#  updated_at      :datetime
#
# Indexes
#
#  index_face_images_on_image_path       (image_path)
#  index_face_images_on_source_category  (source_category)
#  index_face_images_on_tag              (tag)
#

require 'rails_helper'

RSpec.describe FaceImage, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
