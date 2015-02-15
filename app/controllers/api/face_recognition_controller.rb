class Api::FaceRecognitionController < Api::BaseController
  def recognize
    raise "invalid params" if params[:upload_file].blank?
    upload_file = params[:upload_file]
    name = upload_file.original_filename.underscore
    path = FaceImage.generate_file_path(name)
    file = File.open(path, 'wb') { |f| f.write(upload_file.read)}
    @face_image = FaceImage.new(image_path: path, original_name: name, source_category: :smartphone_app)
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
    raise "invalid params" if params[:tag_name].blank? || params[:id].blank?
    face_image = FaceImage.find_by!(id: params[:id])
    face_image.update!(tag: params[:tag_name])
    head(:ok)
  end
end
