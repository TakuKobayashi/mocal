class CreateMorphemes < ActiveRecord::Migration
  def change
    create_table :morphemes do |t|
      t.string  :word,    null: false
      t.string  :pos,     null: false
      t.integer :counter, null: false, default: 0
      t.timestamps
    end
    add_index :morphemes, :word
    add_index :morphemes, :pos
  end
end
