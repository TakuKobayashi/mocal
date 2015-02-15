class CreateFaceImages < ActiveRecord::Migration
  def change
    create_table :face_images do |t|
      t.string  :image_path, null: false
      t.string  :source_url
      t.string  :keyword
      t.string  :tag
      t.string  :original_name, null: false
      t.integer :source_category, null: false
      t.timestamps
    end
    add_index :face_images, :image_path
    add_index :face_images, :tag
    add_index :face_images, :source_category
  end
end
