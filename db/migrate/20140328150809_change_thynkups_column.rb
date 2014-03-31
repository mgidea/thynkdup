class ChangeThynkupsColumn < ActiveRecord::Migration
  def up
    remove_column :thynkups, :user_id, :integer
    add_column    :thynkups, :friend_id, :integer

    add_index     :thynkups, [:friend_id, :thynker_id], unique: true
  end

  def down
    remove_index :thynkups, column: [:friend_id, :thynker_id]

    add_column    :thynkups, :user_id, :integer
    remove_column :thynkups, :friend_id, :integer
  end
end
