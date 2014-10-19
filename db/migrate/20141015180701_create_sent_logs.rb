class CreateSentLogs < ActiveRecord::Migration
  def change
    create_table :sent_logs do |t|
      t.integer :speech_recognize_id, null: false
      t.string  :address,             null: false
      t.timestamps
    end
    add_index :sent_logs, :speech_recognize_id
    add_index :sent_logs, :address
  end
end
