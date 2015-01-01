class CreateMstMusicMeta < ActiveRecord::Migration
  def change
    create_table :mst_music_meta do |t|
      t.integer :mst_music_id, null: false
      t.float   :bpm
      t.float   :playing_time, null: false, default: 0
      t.string  :file_path, null: false
      t.integer :upload_id
      t.timestamps
    end
    add_index :mst_music_meta, :mst_music_id
    add_index :mst_music_meta, :upload_id
  end
end
