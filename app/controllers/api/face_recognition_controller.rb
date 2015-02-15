class Api::FaceRecognitionController < Api::BaseController
  def recognize
    raise "invalid params" if params[:upload_file].blank?
    upload_file = params[:upload_file]
    name = upload_file.original_filename.underscore
    path = FaceImage.generate_file_path(name)
    file = File.open(path, 'wb') { |f| f.write(upload_file.read)}
    width, height = FastImage.size(path)
    @face_image = FaceImage.new(image_path: path, original_name: name, source_category: :smartphone_app, width: width, height: height)
    if @face_image.pre_recognize_face.blank?
      head(208)
      return
    else
      FaceImage.transaction do
        @face_image.save!
        @face_infos = @face_image.recognize_from_opencv!
      end
    end
  end

  def tag
    raise "invalid params" if params[:tag_name].blank? || params[:face_image_info_id].blank?
    face_image_info = FaceImageInfo.find_by!(id: params[:face_image_info_id])
    face_image_info.update!(tag: params[:tag_name])
    head(:ok)
  end
end
