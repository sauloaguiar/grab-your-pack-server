class Building < ActiveRecord::Base
  has_many :apartments
  validates :address_1, :zip_code, :state, :city, presence: true
  validates :address_1, :address_2, :city, :state, :country, :zip_code, uniqueness: true

  #accepts_nested_attributes_for :apartments
end
