class AddPointValueToFeedItem < ActiveRecord::Migration
  def change
    add_column :feed_items, :point_value, :integer
  end
end
