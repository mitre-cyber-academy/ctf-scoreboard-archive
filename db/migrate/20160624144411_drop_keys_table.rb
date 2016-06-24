class DropKeysTable < ActiveRecord::Migration
  def up
    drop_table :keys
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
