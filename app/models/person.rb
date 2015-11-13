class Person < ActiveRecord::Base
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  has_many :occupants
  has_many :apartments, through: :occupants

  def name
    [first_name, last_name].join " "
  end
end
