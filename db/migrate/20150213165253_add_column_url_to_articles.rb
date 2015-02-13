class AddColumnUrlToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :url, :string
  end
end
