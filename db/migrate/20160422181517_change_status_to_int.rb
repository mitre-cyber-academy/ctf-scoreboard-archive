class ChangeStatusToInt < ActiveRecord::Migration
  def change
    change_column :challenges, :starting_state, :integer
  end
end
