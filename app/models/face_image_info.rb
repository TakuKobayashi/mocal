# == Schema Information
#
# Table name: face_image_infos
#
#  id              :integer          not null, primary key
#  face_image_id   :integer          not null
#  source_category :integer          not null
#  category        :integer          not null
#  tag             :string(255)
#  left_position   :float(24)        default(0.0), not null
#  right_position  :float(24)        default(0.0), not null
#  top_position    :float(24)        default(0.0), not null
#  bottom_position :float(24)        default(0.0), not null
#  options         :text
#  created_at      :datetime
#  updated_at      :datetime
#
# Indexes
#
#  index_face_image_infos_on_face_image_id_and_category        (face_image_id,category)
#  index_face_image_infos_on_left_position_and_right_position  (left_position,right_position)
#  index_face_image_infos_on_tag                               (tag)
#  index_face_image_infos_on_top_position_and_bottom_position  (top_position,bottom_position)
#

class FaceImageInfo < ActiveRecord::Base
  belongs_to :face_image
end
