class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :mst_company_id, null: false
      t.string  :type, null: false
      t.float   :score, null: false, default: 0
      t.text    :body
      t.string  :title
      t.datetime :post_at
      t.timestamps
    end
    add_index :articles, :mst_company_id
    add_index :articles, :type
    add_index :articles, :post_at
  end
end
