class AddTosToGame < ActiveRecord::Migration
  def change
    add_column :games, :tos, :text
  end
end
