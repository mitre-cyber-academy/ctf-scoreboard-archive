class AddDisableFlagAnHourToGame < ActiveRecord::Migration
  def change
    add_column :games, :disable_flags_an_hour_graph, :boolean, :default => false
  end
end
