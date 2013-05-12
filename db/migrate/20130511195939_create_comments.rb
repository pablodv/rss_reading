class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :article_id
      t.integer :user_id
      t.text :body

      t.timestamps
    end

    add_index :comments, [:user_id, :article_id]
  end
end
