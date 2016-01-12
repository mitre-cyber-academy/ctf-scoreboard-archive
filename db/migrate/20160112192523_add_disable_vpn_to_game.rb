class AddDisableVpnToGame < ActiveRecord::Migration
  def change
    add_column :games, :disable_vpn, :boolean, :default => false
  end
end
