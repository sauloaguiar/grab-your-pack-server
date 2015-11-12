class CreateOccupants < ActiveRecord::Migration
  def change
    create_table :occupants do |t|

      t.timestamps null: false
    end
  end
end
