class CreateSounds < ActiveRecord::Migration
  def change
    create_table :sounds do |t|
      t.string  :wav_file_path, null: false
      t.string  :file_type, null: false
      t.string  :original_name, null: false
      t.integer :millisecond_time, null: false, default: 0
      t.text  :options
      t.timestamps
    end
    add_index :sounds, :original_name
  end
end
