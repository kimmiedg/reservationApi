require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe 'validations' do
    subject {
      Reservation.new(reservation_code: "12345")
    }

    it 'validates uniqueness of reservation code' do
      expect(subject).to validate_uniqueness_of(:reservation_code)
    end

    it 'validates presence of all fields' do
      %i[reservation_code currency status start_date end_date no_of_nights
         no_of_guests no_of_infants no_of_adults no_of_children total_price
         payout_amt security_price guest_id].each do |f|
           expect(subject).to validate_presence_of(f)
      end
    end

  end
end
