class PersonSerializer < ActiveModel::Serializer
  root :user
  attributes :first_name, :last_name, :email, :phone

  has_many :apartments
  has_many :buildings
end
