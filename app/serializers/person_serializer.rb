class PersonSerializer < ActiveModel::Serializer
  root :user
  attributes :id, :first_name, :last_name, :email, :phone
end
