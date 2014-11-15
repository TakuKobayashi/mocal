class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.integer  :mst_company_id, null: false
      t.float    :price, null: false, default: 0
      t.datetime :reported_at, null: false
      t.timestamps
    end
    add_index :companies, :mst_company_id
    add_index :companies, :reported_at
  end
end
