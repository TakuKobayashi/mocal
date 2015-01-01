class CreateMstMusicBeats < ActiveRecord::Migration
  def change
    create_table :mst_music_beats do |t|
      t.integer :mst_music_id, null: false
      t.float   :timing, null: false
      t.integer :number, null: false, default: 0
      t.timestamps
    end
    add_index :mst_music_beats, :mst_music_id
  end
end
