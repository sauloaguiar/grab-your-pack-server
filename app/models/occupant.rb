class Occupant < ActiveRecord::Base
  belongs_to :apartment
  belongs_to :person

  accepts_nested_attributes_for :apartments  
end
