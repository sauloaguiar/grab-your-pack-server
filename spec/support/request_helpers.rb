module Request
  module JsonHelpers
    def json_response
      @json_response ||= JSON.parse(response.body, symbolize_names: true)
    end
  end
end

module Models
  module BuildingHelper
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
  end
  module ApartmentHelper
    def create_apartment(attrs={})
      default_attrs = {
          unit: Faker::Address.building_number,
          building: create_building
      }
      Apartment.create(default_attrs.merge(attrs))
    end
  end
  module PersonHelper
    def create_person(attrs = {})
      default_attrs = {
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
        phone: Faker::Number.number(10)
      }
      Person.create(default_attrs.merge(attrs))
    end
  end
  module NotificationHelper
    def create_notification(attrs = {})
      default_attrs = {
        notification_type: Faker::Address.state,
        discriminator: Faker::Lorem.sentence(3),
        person: create_person
      }
      Notification.create(default_attrs.merge(attrs))
    end
  end
end
