class CreateMstCompanies < ActiveRecord::Migration
  def change
    create_table :mst_companies do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
