class RenameGameidDivisionid < ActiveRecord::Migration
  def change
    remove_column :users, :game_id
    add_column :users, :division_id, :integer
  end
end
