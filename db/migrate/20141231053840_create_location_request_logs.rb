class CreateLocationRequestLogs < ActiveRecord::Migration
  def change
    create_table :location_request_logs do |t|
      t.string  :relation_type
      t.integer :relation_id
      t.string  :address
      t.float   :latitude,       null: false
      t.float   :longitude,      null: false
      t.float   :elevation
      t.string  :ip_address
      t.timestamps
    end
    add_index :location_request_logs, [:relation_type, :relation_id]
    add_index :location_request_logs, [:latitude, :longitude, :elevation], name: "lat_lon_ele_index"
    add_index :location_request_logs, :ip_address
  end
end
