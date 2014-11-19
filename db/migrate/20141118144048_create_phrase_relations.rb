class CreatePhraseRelations < ActiveRecord::Migration
  def change
    create_table :phrase_relations do |t|
      t.integer :morpheme_id, null: false
      t.integer :dependency_id, null: false
      t.string  :source_type, null: false
      t.integer :source_id, null: false
      t.timestamps
    end
    add_index :phrase_relations, [:morpheme_id, :source_type, :source_id], name: "morphemes_index"
    add_index :phrase_relations, [:dependency_id, :source_type, :source_id], name: "dependencies_index"
  end
end
