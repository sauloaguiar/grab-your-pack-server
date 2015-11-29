class ApartmentSerializer < ActiveModel::Serializer
  root :apartment
  attributes :id, :unit, :building_id
end
