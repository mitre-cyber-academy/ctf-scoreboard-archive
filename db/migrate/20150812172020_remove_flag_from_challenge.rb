class RemoveFlagFromChallenge < ActiveRecord::Migration
  def change
    remove_column :challenges, :flag, :string
  end
end
