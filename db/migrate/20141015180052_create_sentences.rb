class CreateSentences < ActiveRecord::Migration
  def change
    create_table :sentences do |t|
      t.integer :user_id,          null: false
      t.string  :source_type,      null: false
      t.integer :source_id,        null: false
      t.text    :origin_sentence
      t.text    :fixture_sentence
      t.integer :status,        null: false
      t.string  :language_code, null: false
      t.timestamps
    end
    add_index :sentences, :user_id
    add_index :sentences, [:source_type, :source_id]
    add_index :sentences, :status
  end
end
