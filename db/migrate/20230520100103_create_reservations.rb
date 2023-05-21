class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.string :currency
      t.string :reservation_code
      t.string :status
      t.date :start_date
      t.date :end_date
      t.integer :no_of_nights
      t.integer :no_of_guests
      t.integer :no_of_infants
      t.integer :no_of_adults
      t.integer :no_of_children
      t.float :total_price, default: 0.0
      t.float :payout_amt, default: 0.0
      t.float :security_price, default: 0.0
      t.integer :guest_id

      t.timestamps null: false
    end
  end
end
