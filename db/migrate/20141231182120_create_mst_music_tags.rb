class CreateMstMusicTags < ActiveRecord::Migration
  def change
    create_table :mst_music_tags do |t|
      t.string  :source_type, null: false
      t.integer :source_id, null: false
      t.string  :key, null: false
      t.integer :value, null: false
      t.timestamps
    end
    add_index :mst_music_tags, [:source_type, :source_id]
    add_index :mst_music_tags, :key
    add_index :mst_music_tags, :value
  end
end
