require 'rails_helper'

RSpec.describe Building, type: :model do

  context "has a valid factory" do
    let(:building) { create_building() }
    it "should have a valid instance" do
        expect(building).to be_valid
    end
    it "should get saved" do
        expect(building.save).to be true
    end
  end

  context "when address_1 is empty" do
    let(:building) { create_building(address_1:nil) }
    it "is not valid" do
      expect(building).to_not be_valid
    end
    it "don't get saved" do
      expect(building.save).to be false
    end
  end

  context "when zip_code is empty" do
    let(:building) { create_building(zip_code:nil) }
    it "is not valid" do
      expect(building).to_not be_valid
    end
    it "don't get saved" do
      expect(building.save).to be false
    end
  end

  context "when state is empty" do
    let(:building) { create_building(state:nil) }
    it "is not valid" do
      expect(building).to_not be_valid
    end
    it "don't get saved" do
      expect(building.save).to be false
    end
  end

  context "when city is empty" do
    let(:building) { create_building(city:nil) }
    it "is not valid" do
      expect(building).to_not be_valid
    end
    it "don't get saved" do
      expect(building.save).to be false
    end
  end

  context "duplicate address" do
    default_attrs = {
      address_1: Faker::Address.street_address,
      address_2: Faker::Address.secondary_address,
      city: Faker::Address.city,
      state: Faker::Address.state,
      country: Faker::Address.country_code,
      zip_code: Faker::Address.zip
    }
    let(:building) { create_building(default_attrs) }

    it "is not valid" do
      expect(building.save).to be true
      duplicate = create_building(default_attrs)
      expect(duplicate).to_not be_valid
      expect(duplicate.save).to be false
    end
  end

end
