class AddFlagToFeedItems < ActiveRecord::Migration
  def change
    add_reference :feed_items, :flag, index: true, foreign_key: true
  end
end
