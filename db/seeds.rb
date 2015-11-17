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

100.times do |n|
  building = create_building
  building.save
end
