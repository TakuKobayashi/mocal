class CreateMstMusicMoods < ActiveRecord::Migration
  def change
    create_table :mst_music_moods do |t|
      t.integer :mst_music_id, null: false
      t.float   :start_time, null: false, default: 0
      t.float   :end_time, null: false, default: 0
      t.timestamps
    end
    add_index :mst_music_moods, :mst_music_id
  end
end
