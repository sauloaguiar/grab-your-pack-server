class Apartment < ActiveRecord::Base
  has_many :occupants
  has_many :persons, through: :occupants

  belongs_to :building

  validates :unit, :building_id, presence: true

  has_many :apartment_notifications
  has_many :notifications, through: :apartment_notifications

end
