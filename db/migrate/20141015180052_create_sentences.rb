class CreateSentences < ActiveRecord::Migration
  def change
    create_table :sentences do |t|
      t.string  :source_type, null: false
      t.integer :source_id, null: false
      t.integer :mst_company_id, null: false
      t.text    :body
      t.float   :score, null: false, default: 0
      t.timestamps
    end
    add_index :sentences, [:source_type, :source_id]
    add_index :sentences, :mst_company_id
  end
end
