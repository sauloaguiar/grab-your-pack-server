class AddColumnToApartment < ActiveRecord::Migration
  def change
    add_column :apartments, :building_id, :integer
    add_index :apartments, :building_id
  end
end
