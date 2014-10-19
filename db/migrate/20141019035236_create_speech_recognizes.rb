class CreateSpeechRecognizes < ActiveRecord::Migration
  def change
    create_table :speech_recognizes do |t|
      t.integer :user_id, null: false
      t.integer :status, null: false
      t.string  :token,  null: false
      t.timestamps
    end
    add_index :speech_recognizes, :token, unique: true
    add_index :speech_recognizes, [:user_id, :status]
  end
end
