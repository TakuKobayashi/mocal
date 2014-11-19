class CreateMstCompanies < ActiveRecord::Migration
  def change
    create_table :mst_companies do |t|
      t.string  :name,          null: false
      t.integer :category_code, null: false
      t.integer :stock_code,    null: false
      t.string  :search_name,   null: false
      t.timestamps
    end
  end
end
