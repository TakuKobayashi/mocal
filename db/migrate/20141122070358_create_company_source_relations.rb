class CreateCompanySourceRelations < ActiveRecord::Migration
  def change
    create_table :company_source_relations do |t|
      t.integer :mst_company_id, null: false
      t.string  :source_type, null: false
      t.integer :source_id, null: false
      t.timestamps
    end
    add_index :company_source_relations, [:source_type, :source_id]
    add_index :company_source_relations, :mst_company_id
  end
end
