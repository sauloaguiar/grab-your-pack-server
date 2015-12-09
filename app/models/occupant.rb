class Occupant < ActiveRecord::Base
  belongs_to :apartment
  belongs_to :person
end
