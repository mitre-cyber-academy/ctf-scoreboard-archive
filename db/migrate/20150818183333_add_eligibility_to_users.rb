class AddEligibilityToUsers < ActiveRecord::Migration
  def change
    add_column :users, :eligible, :boolean, :default => true
  end
end
