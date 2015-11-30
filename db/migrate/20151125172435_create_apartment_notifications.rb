class CreateApartmentNotifications < ActiveRecord::Migration
  def change
    create_table :apartment_notifications do |t|

      t.timestamps null: false
    end
  end
end
