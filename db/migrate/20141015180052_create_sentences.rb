class CreateSentences < ActiveRecord::Migration
  def change
    create_table :sentences do |t|
      t.integer :article_id,          null: false
      t.text    :body
      t.float   :score, null: false, default: 0
      t.timestamps
    end
    add_index :sentences, :article_id
  end
end
