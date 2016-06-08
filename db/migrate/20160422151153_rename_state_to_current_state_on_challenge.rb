class RenameStateToCurrentStateOnChallenge < ActiveRecord::Migration
  def change
    rename_column :challenges, :state, :starting_state
  end
end
