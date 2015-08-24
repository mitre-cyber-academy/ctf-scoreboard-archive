class CreateFlags < ActiveRecord::Migration
  def change
    create_table :flags do |t|
      t.references :challenge, index: true, foreign_key: true
      t.string :flag
      t.string :api_request
      t.string :video_url

      t.timestamps null: false
    end
  end
end
