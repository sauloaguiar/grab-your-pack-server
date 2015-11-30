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

end
