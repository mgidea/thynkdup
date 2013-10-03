class CreateNutshells < ActiveRecord::Migration
  def change
    create_table :nutshells do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.string :content, null: false

      t.timestamps
    end
  end
end
