class CreateFaceImageInfos < ActiveRecord::Migration
  def change
    create_table :face_image_infos do |t|
      t.integer :face_image_id, null: false
      t.integer :source_category, null: false
      t.integer :category, null: false
      t.float :left_position, null: false, default: 0
      t.float :right_position, null: false, default: 0
      t.float :top_position, null: false, default: 0
      t.float :bottom_position, null: false, default: 0
      t.timestamps
    end
    add_index :face_image_infos, [:face_image_id, :category]
    add_index :face_image_infos, [:left_position, :right_position]
    add_index :face_image_infos, [:top_position, :bottom_position]
  end
end
