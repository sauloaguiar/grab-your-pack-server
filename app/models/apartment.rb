class Apartment < ActiveRecord::Base
  has_many :occupants
  has_many :persons, through: :occupants

  belongs_to :building

  #validates :unit, :building_id, presence: true
  validates :unit, presence: true

  has_many :notifications

end
