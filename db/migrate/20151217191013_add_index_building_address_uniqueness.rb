class AddIndexBuildingAddressUniqueness < ActiveRecord::Migration
  def change
    add_index "buildings",
            ['address_1', 'address_2', 'city', 'state', 'country', 'zip_code'],
            :unique => true,
            :name => "unique_address"
  end
end
