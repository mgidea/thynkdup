class RemoveColumnsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :occupation, :string
    remove_column :users, :interests, :string
    remove_column :users, :aspirations, :string
    remove_column :users, :goals, :string
    remove_column :users, :recommendations, :string
  end
end
