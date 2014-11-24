class AddIndexStatusToCrawlLogs < ActiveRecord::Migration
  def change
    add_index :crawl_logs, :status
  end
end
