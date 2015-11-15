require 'rails_helper'

RSpec.describe Building, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"


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

  context "has a valid factory" do
    let(:building) { create_building() }
    it "should have a valid instance" do
        expect(building).to be_valid
    end
    it "should get saved" do
        expect(building.save).to be true
    end
  end


end
