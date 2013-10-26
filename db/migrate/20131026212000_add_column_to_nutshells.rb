class AddColumnToNutshells < ActiveRecord::Migration
  def change
    add_column :nutshells, :keywords, :text
  end
end
