class AddColumnToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :person_id, :integer, :null => false
    add_index :notifications, :person_id
  end
end
