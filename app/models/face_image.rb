# == Schema Information
#
# Table name: face_images
#
#  id              :integer          not null, primary key
#  image_path      :string(255)      not null
#  source_url      :string(255)
#  keyword         :string(255)
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
#

require 'opencv'

class FaceImage < ActiveRecord::Base
  has_many :face_image_infos

  enum source_category: [
    :rails_app,
    :smartphone_app
  ]

  FACEIMAGE_FILE_ROOT_PATH = "/tmp/image/face/"

  def self.generate_file_path(file_name)
    extname = File.extname(file_name)
    return Rails.root.to_s + FACEIMAGE_FILE_ROOT_PATH + SecureRandom.hex(30) + extname
  end

  def pre_recognize_face(image_path = nil)
    @face_image = OpenCV::IplImage::load(image_path || self.image_path)
    @face_rects = recognize_opencv_common(@face_image, "face"){|rect| rect}
    return @face_rects
  end

  def recognize_from_opencv!
    image = @face_image || OpenCV::IplImage::load(self.image_path)
    if @face_rects.present?
      face_infos = @face_rects.map do |rect|
      	self.face_image_infos.new({
            left_position: rect.x,
            right_position: rect.x + rect.width,
            top_position: rect.y,
            bottom_position: rect.y + rect.height,
            source_category: :opencv,
            category: "face"
          })
      end
    else
      face_infos = recognize_opencv_common(image, "face") do |rect|
        self.face_image_infos.new({
            left_position: rect.x,
            right_position: rect.x + rect.width,
            top_position: rect.y,
            bottom_position: rect.y + rect.height,
            source_category: :opencv,
            category: "face"
          })
      end
    end

    other_infos = []
    FaceImageInfo.categories.keys.each do |key|
      next if key == "face"
      other_infos += recognize_opencv_common(image, key) do |rect|
      	#各パーツ検出したものは顔の中にあるはずなので、顔の中にあるものだけで絞り込み
        if face_infos.any?{|info| info.in_face?(rect) }
          self.face_image_infos.new({
            left_position: rect.x,
            right_position: rect.x + rect.width,
            top_position: rect.y,
            bottom_position: rect.y + rect.height,
            source_category: :opencv,
            category: key
          })
        end
      end
    end
    all_face_infos = face_infos + other_infos
    FaceImageInfo.import(all_face_infos)
    return all_face_infos
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
