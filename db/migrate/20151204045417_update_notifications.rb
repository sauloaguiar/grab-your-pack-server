class UpdateNotifications < ActiveRecord::Migration
  def change
    change_table :notifications do |t|
      remove_column :notifications, :discriminator
      t.integer :apartment_id

      #t.index :apartments, :apartment_id
    end
  end
end
