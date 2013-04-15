class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.integer :user_id
      t.string :url
      t.string :name

      t.timestamps
    end
  end
end
