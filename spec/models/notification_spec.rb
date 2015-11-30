require 'rails_helper'

RSpec.describe Notification, type: :model do
  
  context "has a valid factory" do
    let(:notification) { create_notification() }
    it "should have a valid instance" do
        expect(notification).to be_valid
    end
    it "should get saved" do
        expect(notification.save).to be true
    end
  end

  context "is invalid without a user id" do
    let(:notification) { create_notification(person_id:nil) }
    it "is not valid" do
      expect(notification).to_not be_valid
    end

    it "should not get saved" do
      expect(notification.save).to be false
    end
  end

  context "the notification has a owner" do
    let(:person) { create_person }
    let(:notification) { create_notification(person: person) }
    it "has the correct person id on it" do
      expect(notification.person.id).to eq(person.id)
    end
  end
end
