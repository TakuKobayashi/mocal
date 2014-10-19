class CreateKeyPhrases < ActiveRecord::Migration
  def change
    create_table :key_phrases do |t|
      t.integer :sentence_id,   null: false
      t.string  :keyphrase,     null: false
      t.float   :score,         null: false
      t.timestamps
    end
    add_index :key_phrases, :sentence_id
    add_index :key_phrases, :keyphrase
  end
end
