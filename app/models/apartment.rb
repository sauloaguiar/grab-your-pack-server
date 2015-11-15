class Apartment < ActiveRecord::Base
  has_many :occupants
  has_many :persons, through: :occupants

  belongs_to :building
end
