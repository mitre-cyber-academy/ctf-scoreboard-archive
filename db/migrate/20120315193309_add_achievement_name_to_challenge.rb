class AddAchievementNameToChallenge < ActiveRecord::Migration
  def change
    add_column :challenges, :achievement_name, :string
  end
end
