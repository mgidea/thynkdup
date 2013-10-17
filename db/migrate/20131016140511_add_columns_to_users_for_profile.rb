class AddColumnsToUsersForProfile < ActiveRecord::Migration
  def change
    add_column :users, :occupation, :string
    add_column :users, :interests, :string
    add_column :users, :aspirations, :string
    add_column :users, :goals, :string
    add_column :users, :recommendations, :string
  end
end
