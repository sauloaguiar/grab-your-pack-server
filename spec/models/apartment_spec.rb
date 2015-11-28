require 'rails_helper'

RSpec.describe Apartment, type: :model do

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

  def create_apartment(attrs={})
    default_attrs = {
        unit: Faker::Address.building_number,
        building: create_building
    }
    Apartment.create(default_attrs.merge(attrs))
  end

  context "has a valid factory" do
    let(:apartment) { create_apartment() }
    it "should have a valid instance" do
        expect(apartment).to be_valid
    end
    it "should get saved" do
        expect(apartment.save).to be true
    end
  end

  context "when unit is empty" do
    let(:apartment) { create_apartment(unit: "") }
    it "is not valid" do
      expect(apartment).to_not be_valid
    end

    it "should not get saved" do
      expect(apartment.save).to be false
    end
  end


end
