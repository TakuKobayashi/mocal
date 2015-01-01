class CreateMstMusicAlbums < ActiveRecord::Migration
  def change
    create_table :mst_music_albums do |t|
      t.string  :gn_id
      t.integer :mst_musician_id
      t.string  :title
      t.string  :jacket_image_path
      t.string  :client_id, null: false
      t.timestamps
    end
    add_index :mst_music_albums, :gn_id
    add_index :mst_music_albums, :mst_musician_id
    add_index :mst_music_albums, :client_id
  end
end
