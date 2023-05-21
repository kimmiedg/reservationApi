class Guest < ApplicationRecord
  has_many :reservations

  validates_uniqueness_of :email
end
