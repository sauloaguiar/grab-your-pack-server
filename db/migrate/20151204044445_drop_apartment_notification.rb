class DropApartmentNotification < ActiveRecord::Migration
  def change
    change_table :apartment_notifications do |t|
      t.remove_index :apartment_id
      t.remove_index :notification_id
    end
    drop_table :apartment_notifications
  end
end
