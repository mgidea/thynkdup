class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :content, null: false
      t.integer :nutshell_id, null: false

      t.timestamps
    end
  end
end
