class PersonSerializer < ActiveModel::Serializer
  root :user
  attributes :id, :first_name, :last_name, :email, :phone, :building

  has_many :apartments
  #has_many :buildings

  def building
    {
      id: object.buildings.first.try(:id),
      apartments: object.apartments.first
    }
  end
end
