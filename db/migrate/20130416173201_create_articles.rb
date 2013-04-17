class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :link
      t.text :description
      t.datetime :published_at
      t.integer :channel_id

      t.timestamps
    end
  end
end
