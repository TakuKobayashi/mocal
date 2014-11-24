class AddIndexSourceTypeAndSourceIdToPhraseRelations < ActiveRecord::Migration
  def change
    add_index :phrase_relations, [:source_type, :source_id]
  end
end
