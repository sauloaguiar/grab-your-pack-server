class Building < ActiveRecord::Base
  has_many :apartments
  validates :address_1, :zip_code, :state, :city, presence: true
end
