class Guest < ApplicationRecord
  has_many :reservations

  validates_uniqueness_of :email
  validates_presence_of :email, :first_name, :last_name, :phone_numbers

  before_save :remove_duplicate_phone_no

  private
    def remove_duplicate_phone_no
      self.phone_numbers += phone_numbers
      self.phone_numbers = self.phone_numbers.uniq
    end
end
