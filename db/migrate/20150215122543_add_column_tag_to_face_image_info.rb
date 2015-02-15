class AddColumnTagToFaceImageInfo < ActiveRecord::Migration
  def change
    add_column :face_image_infos, :tag, :string
    add_index :face_image_infos, :tag
  end
end
