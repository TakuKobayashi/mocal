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
#  created_at      :datetime
#  updated_at      :datetime
#
# Indexes
#
#  index_face_images_on_image_path       (image_path)
#  index_face_images_on_source_category  (source_category)
#  index_face_images_on_tag              (tag)
#

require 'opencv'

class FaceImage < ActiveRecord::Base
  has_many :face_image_infos

  def recognize_from_opencv!(tag = nil, options = {})
    image = OpenCV::IplImage::load(self.image_path)
    face_infos = recognize_opencv_common(image, "face") do |rect|
      self.face_image_infos.record!(rect, {source_category: :opencv, category: "face", tag: tag}, options)
    end
    other_infos = []
    FaceImageInfo.categories.keys.each do |key|
      next if key == "face"
      other_infos += recognize_opencv_common(image, key) do |rect|
      	#各パーツ検出したものは顔の中にあるはずなので、顔の中にあるものだけで絞り込み
      	if face_infos.any?{|info| info.in_face?(rect) }
          self.face_image_infos.record!(rect, {source_category: :opencv, category: key, tag: tag}, options)
        end
      end
    end
    return face_infos + other_infos
  end

  private
  def recognize_opencv_common(image, key, &block)
  	array = []
  	detector = OpenCV::CvHaarClassifierCascade::load(FaceImageInfo.detector_file_path(key))
    detector.detect_objects(image).each do |rect|
      array << block.call(rect)
    end
    return array.compact
  end
end
