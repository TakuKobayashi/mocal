class CreateDependencies < ActiveRecord::Migration
  def change
    create_table :dependencies do |t|
      t.string  :word,    null: false
      t.string  :pos,     null: false
      t.integer :counter, null: false, default: 0
      t.timestamps
    end
    add_index :dependencies, :word
    add_index :dependencies, :pos
  end
end
