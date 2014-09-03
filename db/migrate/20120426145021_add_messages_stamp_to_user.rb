class AddMessagesStampToUser < ActiveRecord::Migration
  def change
    add_column :users, :messages_stamp, :datetime
  end
end
