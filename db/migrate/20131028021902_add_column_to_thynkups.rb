class AddColumnToThynkups < ActiveRecord::Migration
  def change
    add_column :thynkups, :status, :string, null: false, default: "pending"
  end
end
