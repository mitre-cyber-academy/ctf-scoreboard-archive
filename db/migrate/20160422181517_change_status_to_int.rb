class ChangeStatusToInt < ActiveRecord::Migration
  def change
    change_column :challenges, :starting_state, 'integer USING CAST(starting_state AS integer)'
  end
end
