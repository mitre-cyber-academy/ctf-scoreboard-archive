class AddGameIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :game_id, :integer
  end
end
