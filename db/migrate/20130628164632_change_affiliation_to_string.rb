class ChangeAffiliationToString < ActiveRecord::Migration
  def change
    add_column :users, :affiliation, :string	
  end	
end
