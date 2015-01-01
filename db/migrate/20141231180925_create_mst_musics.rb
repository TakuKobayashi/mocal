class CreateMstMusics < ActiveRecord::Migration
  def change
    create_table :mst_musics do |t|
      t.string   :gn_id
      t.integer  :mst_musician_id
      t.string   :title
      t.datetime :release_date
      t.integer  :duration, null: false, default: 0
      t.string   :client_id, null: false
      t.timestamps
    end
    add_index :mst_musics, :gn_id
    add_index :mst_musics, :release_date
    add_index :mst_musics, :mst_musician_id
    add_index :mst_musics, :duration
    add_index :mst_musics, :client_id
  end
end
