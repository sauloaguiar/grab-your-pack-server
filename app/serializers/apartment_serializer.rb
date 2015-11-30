class ApartmentSerializer < ActiveModel::Serializer
  root :apartment
  attributes :id, :unit, :building_id

  #has_one :building
end
