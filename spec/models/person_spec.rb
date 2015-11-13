require 'rails_helper'

describe Person do

  def create_person(attrs = {})
    default_attrs = {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      phone: Faker::Number.number(10)
    }
    Person.create(default_attrs.merge(attrs))
  end

  context "has a valid factory" do
    let(:person) { create_person() }
    it "should have a valid instance" do
        expect(person).to be_valid
    end
    it "should get saved" do
        expect(person.save).to be true
    end
  end

  context "when first name is empty" do
    let(:person) { create_person(first_name: nil) }
    it "should not be valid" do
      expect(person).to_not be_valid
    end
    it "should not get saved" do
      expect(person.save).to be false
    end
  end

  context "when last name is empty" do
    let(:person) { create_person(last_name: nil) }
    it "should not be valid" do
      expect(person).to_not be_valid
    end
    it "should not get saved" do
      expect(person.save).to be false
    end
  end

  context "when email is empty" do
    let(:person) { create_person(email: nil) }
    it "should not be valid" do
      expect(person).to_not be_valid
    end
    it "should not get saved" do
      expect(person.save).to be false
    end
  end

  context "duplicated email address" do
    it "should not be valid" do
      expect(create_person(email: "test@email.com")).to be_valid
      expect(create_person(email: "test@email.com")).to_not be_valid
    end
  end

  context "invalid email address" do
    it "doesn't accept invalid domain name" do
      expect(create_person(email: "t@m,com")).to_not be_valid
    end
    it "doesn't accept invalid username" do
      expect(create_person(email: "*&â@m,com")).to_not be_valid
    end
  end

  context "accessing person's full name" do
    it "should return as a string" do
      person = create_person(first_name: "Saulo", last_name: "Aguiar")
      expect(person.name).to eq "Saulo Aguiar"
    end
  end
  
end
