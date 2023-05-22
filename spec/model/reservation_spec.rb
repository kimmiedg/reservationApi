require 'rails_helper'

RSpec.describe Reservation do
  subject {
    Reservation.new(reservation_code: "5896", status: "confirmed", currency: "AUD", no_of_guests: 4,
      start_date: Date.today, end_date: Date.today + 1, no_of_adults: 2, no_of_children: 1,
      no_of_infants: 1, no_of_nights: 1, total_price: 120, payout_amt: 85.0, security_price: 35)
  }

  it 'validates uniqueness of reservation_code and guest email' do
    guest = Guest.create(email: "kiwi@fruit.com", first_name: "Kiwi", last_name: "Fruit", phone_numbers: ["639123456789"])
    subject.guest = guest
    subject.save!

    reservation = Reservation.create(reservation_code: "5896", status: "confirmed", currency: "AUD", no_of_guests: 4,
        start_date: Date.today, end_date: Date.today + 1, no_of_adults: 2, no_of_children: 1, no_of_infants: 1,
        no_of_nights: 1, total_price: 120, payout_amt: 85.0, security_price: 35, guest: guest)

    expect(reservation.errors[:base]).to include("Guest and reservation code exists")
  end

  it 'validates presence of all fields' do
    guest = Guest.create(email: "kiwi@fruit.com", first_name: "Kiwi", last_name: "Fruit", phone_numbers: ["639123456789"])
    subject.guest = guest

    expect(subject).to be_valid
    expect(subject.save).to be true
  end
end
