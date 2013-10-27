class CreateThynkups < ActiveRecord::Migration
  def change
    create_table :thynkups do |t|
      t.integer :thynker_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
