class CreateEnvironmentData < ActiveRecord::Migration
  def change
    create_table :environment_data do |t|
      t.integer  :mst_environment_sensor_id, null: false
      t.integer  :data_category, null: false
      t.datetime :obs_datetime, null: false
      t.float    :val, null: false
      t.timestamps
    end
    add_index :environment_data, :mst_environment_sensor_id
    add_index :environment_data, :obs_datetime
  end
end
