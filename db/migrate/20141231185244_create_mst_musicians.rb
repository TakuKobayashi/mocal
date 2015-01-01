class CreateMstMusicians < ActiveRecord::Migration
  def change
    create_table :mst_musicians do |t|
      t.string :name, null: false
      t.string :image_url
      t.string :client_id, null: false
      t.timestamps
    end
    add_index :mst_musicians, :client_id
  end
end
