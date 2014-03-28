class ChangeThynkupsColumn < ActiveRecord::Migration
  def up
    remove_column :thynkups, :user_id, :integer
    add_column    :thynkups, :friend_id, :integer
  end

  def down
    add_column    :thynkups, :user_id, :integer
    remove_column :thynkups, :friend_id, :integer
  end
end
