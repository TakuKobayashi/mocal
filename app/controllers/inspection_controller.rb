class InspectionController < ApplicationController
  def show
  end

  def draw
  end

  def face_recognize
  end

  def face_recognize_result
  	upload_file = params[:upload_file]
    name = upload_file.original_filename.underscore
    @path = FaceImage.generate_file_path(name)
    file = File.open(@path, 'wb') { |f| f.write(upload_file.read)}
    width, height = FastImage.size(@path)
    face_image = FaceImage.new(image_path: @path, original_name: name, source_category: :smartphone_app, width: width, height: height)
    if face_image.pre_recognize_face.present?
      FaceImage.transaction do
        face_image.save!
        @face_infos = face_image.recognize_from_opencv!
      end
    end
  end
end
