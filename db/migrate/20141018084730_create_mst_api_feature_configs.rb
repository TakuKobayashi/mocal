class CreateMstApiFeatureConfigs < ActiveRecord::Migration
  def change
    create_table :mst_api_feature_configs do |t|
      t.integer  :mst_api_config_id, null: false
      t.integer  :category,          null: false
      t.string   :request_url,       null: false
      t.integer  :request_format,    null: false
      t.integer  :limit_count
      t.integer  :limit_request_capacity
      t.datetime :limited_at
      t.timestamps
    end
    add_index :mst_api_feature_configs, [:mst_api_config_id, :category, :request_url], unique: true, name: "mst_api_feature_configs_request_index"
  end
end
