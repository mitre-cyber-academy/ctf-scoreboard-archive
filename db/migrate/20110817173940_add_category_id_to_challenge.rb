class AddCategoryIdToChallenge < ActiveRecord::Migration
  def change
    add_column :challenges, :category_id, :integer
  end
end
