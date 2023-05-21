class Reservation < ApplicationRecord
  belongs_to :guest
  validates_presence_of :reservation_code, :currency, :status, :start_date, :end_date,
                        :no_of_nights, :no_of_guests, :no_of_infants, :no_of_adults,
                        :no_of_children, :total_price, :payout_amt, :security_price, :guest_id
  validate :reservation_code_guest_email_unique

  accepts_nested_attributes_for :guest

  private

    def reservation_code_guest_email_unique
      binding.pry
      # guest = Guest.find_by_id(guest_id)
      # reservation = where(reservation_code: reservation_code, )
      # if Guest.exists?(email: email) && Reservation.exists?(reservation_code: reservation_code)
      #   errors.add(:base, "Email and Reservation already exists.")
      # end
    end
end
