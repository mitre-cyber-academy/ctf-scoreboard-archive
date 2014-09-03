class AddChallengeIdToFeedItem < ActiveRecord::Migration
  def change
    add_column :feed_items, :challenge_id, :integer
  end
end
