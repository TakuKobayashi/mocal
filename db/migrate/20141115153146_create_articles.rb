class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :mst_company_id, null: false
      t.float   :score, null: false, default: 0
      t.string  :type, null: false
      t.text    :body
      t.string  :title
      t.datetime :post_at
      t.integer  :category
      t.string   :data_id, null: false
      t.timestamps
    end
    add_index :articles, :mst_company_id
    add_index :articles, :post_at
    add_index :articles, :data_id
  end
end
