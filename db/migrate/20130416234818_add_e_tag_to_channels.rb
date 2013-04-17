class AddETagToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :etag, :string
  end
end
