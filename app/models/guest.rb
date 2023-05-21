class Guest < ApplicationRecord
  has_many :reservations

  validates_uniqueness_of :email
  validates_presence_of :email, :first_name, :last_name, :phone_numbers

end
