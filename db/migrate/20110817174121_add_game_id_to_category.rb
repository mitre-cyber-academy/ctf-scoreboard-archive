class AddGameIdToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :game_id, :integer
  end
end
