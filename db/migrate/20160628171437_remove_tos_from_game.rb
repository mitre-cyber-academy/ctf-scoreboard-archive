class RemoveTosFromGame < ActiveRecord::Migration
  def change
    remove_column :games, :tos
  end
end
