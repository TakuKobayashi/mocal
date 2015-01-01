class CreateMstMusicRelations < ActiveRecord::Migration
  def change
    create_table :mst_music_relations do |t|
      t.integer :mst_music_id, null: false
      t.string  :source_type, null: false
      t.integer :source_id, null: false
      t.timestamps
    end
    add_index :mst_music_relations, [:mst_music_id, :source_type, :source_id], name: "music_relation_index"
    add_index :mst_music_relations, [:source_type, :source_id]
  end
end
