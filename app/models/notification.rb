class Notification < ActiveRecord::Base
  belongs_to :person
  belongs_to :aparment

  validates :person_id, presence: true
end
