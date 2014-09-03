class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.integer :game_id
      t.text :text

      t.timestamps
    end
  end
end
