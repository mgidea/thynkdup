class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :occupation
      t.string :interests
      t.string :inspirations
      t.string :aspirations
      t.string :goals
      t.string :recommendations
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
