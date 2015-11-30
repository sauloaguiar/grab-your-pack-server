require 'rails_helper'

RSpec.describe Apartment, type: :model do

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
    let(:apartment) { create_apartment(unit: nil) }
    it "is not valid" do
      expect(apartment).to_not be_valid
    end

    it "should not get saved" do
      expect(apartment.save).to be false
    end
  end

  context "when the building is nil" do
    let(:apartment) { create_apartment(building: nil)}
    it "is not valid" do
      expect(apartment).to_not be_valid
    end
    it "should not get saved" do
      expect(apartment.save).to be false
    end
  end


end
