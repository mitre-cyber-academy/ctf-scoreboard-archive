class CreateSubmittedFlags < ActiveRecord::Migration
  def change
    create_table :submitted_flags do |t|
      t.integer :user_id
      t.integer :challenge_id
      t.string :text

      t.timestamps
    end
  end
end
