class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.string :name
      t.text :description
      t.integer :point_value
      t.string :flag
      t.string :state

      t.timestamps
    end
  end
end
