class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.integer  :mst_company_id, null: false
      t.float    :price, null: false, default: 0
      t.datetime :reported_at, null: false
      t.timestamps
    end
    add_index :prices, :mst_company_id
    add_index :prices, :reported_at
  end
end
