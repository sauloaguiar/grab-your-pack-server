class AddColumnToOccupants < ActiveRecord::Migration
  def change
    add_column :occupants, :apartment_id, :integer
    add_column :occupants, :person_id, :integer
  end
end
