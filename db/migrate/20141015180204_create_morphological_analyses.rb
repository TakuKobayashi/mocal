class CreateMorphologicalAnalyses < ActiveRecord::Migration
  def change
    create_table :morphological_analyses do |t|
      t.integer :sentence_id,   null: false
      t.integer :dependency_id
      t.string  :word,          null: false
      t.string  :pos,           null: false
      t.timestamps
    end
    add_index :morphological_analyses, [:sentence_id, :dependency_id]
    add_index :morphological_analyses, :pos
  end
end
