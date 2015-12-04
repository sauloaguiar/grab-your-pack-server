class Notification < ActiveRecord::Base
  has_many :apartment_notifications
  has_many :apartments, through: :apartment_notifications

  belongs_to :person
  belongs_to :aparment

  #validates :person_id, presence: true
end
