class AddLastReadMessageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_read_message_id, :integer
  end
end
