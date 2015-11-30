class ApartmentNotification < ActiveRecord::Base
  belongs_to :apartment
  belongs_to :notification
end
