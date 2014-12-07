class CreateNgrams < ActiveRecord::Migration
  def change
    create_table :ngrams do |t|
      t.string  :word,    null: false
      t.integer :counter, null: false, default: 0
      t.timestamps
    end
    add_index :ngrams, :word
  end
end
