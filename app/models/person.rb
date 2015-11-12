class Person < ActiveRecord::Base
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true

  has_many :occupants
  has_many :apartments, through: :occupants
end
