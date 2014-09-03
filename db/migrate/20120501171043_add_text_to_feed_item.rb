class AddTextToFeedItem < ActiveRecord::Migration
  def change
    add_column :feed_items, :text, :string
  end
end
