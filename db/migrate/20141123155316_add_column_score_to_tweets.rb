class AddColumnScoreToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :score, :float, null: false, default: 0
  end
end
