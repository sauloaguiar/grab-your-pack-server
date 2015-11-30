class AddColumnToApartmentNotification < ActiveRecord::Migration
  def change
    add_column :apartment_notifications, :apartment_id, :integer
    add_column :apartment_notifications, :notification_id, :integer
    add_index :apartment_notifications, :apartment_id
    add_index :apartment_notifications, :notification_id
  end
end
