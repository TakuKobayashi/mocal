class RemoveColumnTagToFaceImage < ActiveRecord::Migration
  def change
    remove_column :face_images, :tag 
  end
end
