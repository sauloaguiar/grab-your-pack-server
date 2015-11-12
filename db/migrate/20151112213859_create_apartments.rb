class CreateApartments < ActiveRecord::Migration
  def change
    create_table :apartments do |t|
      t.string :unit

      t.timestamps null: false
    end
  end
end
