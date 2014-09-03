class AddIrcToGame < ActiveRecord::Migration
  def change
  	add_column :games, :irc, :string
  end
end
