class Reservation < ApplicationRecord
  belongs_to :guest

  accepts_nested_attributes_for :guest
end
