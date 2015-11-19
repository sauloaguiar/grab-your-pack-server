class BuildingSerializer < ActiveModel::Serializer
  attributes :id, :address_1, :address_2, :city, :state, :country, :zip_code
end
