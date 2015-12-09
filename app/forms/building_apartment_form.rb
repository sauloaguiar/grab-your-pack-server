class BuildingApartmentForm
  include ActiveModel::Model
  include Virtus.model

  attribute :address_1, String
  attribute :address_2, String
  attribute :city, String
  attribute :state, String
  attribute :zip_code, String
  attribute :country, String

  attribute :apartments, Array[Apartment]

  attr_reader :apartments
  attr_reader :building

  validates :address_1, :zip_code, :state, :city, presence: true

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  def persist!
    @building = Building.create!(address_1: address_1, address_2: address_2, city: city, state: state, zip_code: zip_code, country: country)
    @apartments = building.apartments.create!(apartments)
  end
end
