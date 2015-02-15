# == Schema Information
#
# Table name: face_image_infos
#
#  id              :integer          not null, primary key
#  face_image_id   :integer          not null
#  source_category :integer          not null
#  category        :integer          not null
#  left_position   :float(24)        default(0.0), not null
#  right_position  :float(24)        default(0.0), not null
#  top_position    :float(24)        default(0.0), not null
#  bottom_position :float(24)        default(0.0), not null
#  created_at      :datetime
#  updated_at      :datetime
#
# Indexes
#
#  index_face_image_infos_on_face_image_id_and_category        (face_image_id,category)
#  index_face_image_infos_on_left_position_and_right_position  (left_position,right_position)
#  index_face_image_infos_on_top_position_and_bottom_position  (top_position,bottom_position)
#

class FaceImageInfo < ActiveRecord::Base
  belongs_to :face_image

  enum category: [
    :face,
    :eye,
    :eyeglasses,
    :nose,
    :mouth
  ]

  enum source_category: [
    :opencv
  ]

  DETECTOR_FILE_ROOT_PATH = "/tmp/opencv/xml/"

  DETECTOR_FILE_NAMES = {
    "face" => "haarcascade_frontalface_alt.xml",
    "eyeglasses" => "haarcascade_eye_tree_eyeglasses.xml",
    "eye" => "haarcascade_eye.xml",
    "nose" => "haarcascade_mcs_nose.xml",
    "mouth" => "haarcascade_mcs_mouth.xml"
  }

  def self.detector_file_path(category)
    return Rails.root.to_s + DETECTOR_FILE_ROOT_PATH + DETECTOR_FILE_NAMES[category]
  end

  def in_face?(rect)
    return false unless face?
    return self.left_position <= rect.x &&
           rect.x + rect.width <= self.right_position &&
           self.top_position <= rect.y &&
           rect.y + rect.height <= self.bottom_position
  end
end
