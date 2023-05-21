class Reservation < ApplicationRecord
  belongs_to :guest
  validates_uniqueness_of :reservation_code
  validates_presence_of :reservation_code, :currency, :status, :start_date, :end_date,
                        :no_of_nights, :no_of_guests, :no_of_infants, :no_of_adults,
                        :no_of_children, :total_price, :payout_amt, :security_price, :guest_id


end
