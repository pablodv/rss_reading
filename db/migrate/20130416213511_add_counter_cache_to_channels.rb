class AddCounterCacheToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :articles_count, :integer, default: 0
  end
end
