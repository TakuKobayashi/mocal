class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string   :tweet, null: false
      t.string   :uid
      t.string   :type, null: false
      t.datetime :post_at
      t.timestamps
    end
    add_index :tweets, :uid
    add_index :tweets, :type
    add_index :tweets, :post_at
  end
end
