class CreateCrawlLogs < ActiveRecord::Migration
  def change
    create_table :crawl_logs do |t|
      t.string   :data_type, null: false
      t.integer  :data_id, null: false
      t.datetime :crawl_at, null: false
      t.integer  :current_crawl_number, null: false, default: 1
      t.integer  :max_crawl_number
      t.integer  :status, null: false
      t.timestamps
    end
    add_index :crawl_logs, [:data_type, :data_id]
    add_index :crawl_logs, :crawl_at
  end
end
