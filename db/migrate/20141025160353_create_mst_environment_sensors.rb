class CreateMstEnvironmentSensors < ActiveRecord::Migration
  def change
    create_table :mst_environment_sensors do |t|
      t.string  :senser_id, null: false
      t.string  :place_name
      t.string  :prefecture
      t.string  :city
      t.float   :lat, null: false, default: 0
      t.float   :lon, null: false, default: 0
      t.timestamps
    end
    add_index :mst_environment_sensors, :senser_id
    add_index :mst_environment_sensors, [:lat, :lon]
  end
end
