class CreateChallengeStates < ActiveRecord::Migration
  def change
    create_table :challenge_states do |t|
      t.integer :state
      t.references :challenge, index: true, foreign_key: true
      t.references :division, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
