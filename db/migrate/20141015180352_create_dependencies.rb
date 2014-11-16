class CreateDependencies < ActiveRecord::Migration
  def change
    create_table :dependencies do |t|
      t.integer :sentence_id,   null: false
      t.string  :word
      t.float   :score,         null: false, default: 0
      t.string  :pos,           null: false
      t.timestamps
    end
    add_index :dependencies, :sentence_id
    add_index :dependencies, :pos
  end
end
