class Reservation < ApplicationRecord
  belongs_to :guest
  validates_presence_of :reservation_code, :currency, :status, :start_date, :end_date,
                        :no_of_nights, :no_of_guests, :no_of_infants, :no_of_adults,
                        :no_of_children, :total_price, :payout_amt, :security_price

  validate :reservation_code_guest_email_unique, on: :create

  accepts_nested_attributes_for :guest

  def guest_attributes=(attributes)
    self.guest = Guest.find_or_create_by(email: attributes["email"]) do |guest|
      guest.attributes = attributes
    end
  end

  private

    def reservation_code_guest_email_unique
      product = Reservation.joins(:guest).find_by(reservation_code: reservation_code, guest: {email: self.guest.email })
      errors.add(:base, "Guest and reservation code exists") if product.present?
    end

end
