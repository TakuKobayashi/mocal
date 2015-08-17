class AddColumnToFaceImageInfos < ActiveRecord::Migration
  def change
    add_column :face_image_infos, :neighbors, :integer, null: false, default: 0
  end
end
