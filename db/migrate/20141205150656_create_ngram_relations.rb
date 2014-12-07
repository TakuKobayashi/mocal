class CreateNgramRelations < ActiveRecord::Migration
  def change
    create_table :ngram_relations do |t|
      t.string  :source_type, null: false
      t.integer :source_id, null: false
      t.integer :ngram_id, null: false
      t.timestamps
    end
    add_index :ngram_relations, [:source_type, :source_id, :ngram_id], name: "ngram_index"
    add_index :ngram_relations, [:ngram_id]
  end
end
