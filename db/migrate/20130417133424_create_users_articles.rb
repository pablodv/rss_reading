class CreateUsersArticles < ActiveRecord::Migration
  def change
    create_table :users_articles do |t|
      t.integer :user_id
      t.integer :article_id

      t.timestamps
    end

    add_index :users_articles, [:user_id, :article_id], unique: true
  end
end
