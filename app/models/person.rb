class Person < ActiveRecord::Base
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  has_many :occupants, inverse_of: :person
  has_many :apartments, through: :occupants

  accepts_nested_attributes_for :apartments

  has_many :buildings, through: :apartments

  has_many :notification

  def name
    [first_name, last_name].join " "
  end

end
