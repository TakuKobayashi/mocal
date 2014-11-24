class CreateWordScores < ActiveRecord::Migration
  def change
    create_table :word_scores do |t|
      t.integer :sentence_id,  null: false
      t.integer :dependency_id
      t.string  :word,         null: false
      t.float   :score,        null: false, default: 0
      t.timestamps
    end
    add_index :word_scores, :sentence_id
    add_index :word_scores, :word
  end
end
