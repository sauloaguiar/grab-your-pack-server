# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

def create_building(attrs = {})
  default_attrs = {
    address_1: Faker::Address.street_address,
    address_2: Faker::Address.secondary_address,
    city: Faker::Address.city,
    state: Faker::Address.state,
    country: Faker::Address.country_code,
    zip_code: Faker::Address.zip
  }
  Building.create(default_attrs.merge(attrs))
end

def create_person(attrs = {})
  default_attrs = {
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    phone: Faker::Number.number(10)
  }
  Person.create(default_attrs.merge(attrs))
end

def create_apartment(attrs={})
  default_attrs = {
      unit: Faker::Address.building_number,
      building_id: create_building
  }
  Apartment.create(default_attrs.merge(attrs))
end



10.times do |n|
  person = create_person
  person.save

  apto = create_apartment
  apto.save
end

# 100.times do |n|
#   building = create_building
#   building.save
# end
