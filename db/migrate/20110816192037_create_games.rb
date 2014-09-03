class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.datetime :start
      t.datetime :stop
      t.text :description

      t.timestamps
    end
  end
end
