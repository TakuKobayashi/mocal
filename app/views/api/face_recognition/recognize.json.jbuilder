json.id @face_image.id
json.width @face_image.width
json.height @face_image.height
json.set! "face_infos" do
  json.array!(@face_infos) do |face_info|
    json.extract! face_info, :category, :left_position, :right_position, :top_position, :bottom_position
  end
end