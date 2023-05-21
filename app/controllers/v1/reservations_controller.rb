class V1::ReservationsController < ApplicationController
  before_action :set_reservation, only: [:index, :update, :show, :delete]

  def create
    parsed_reservation = ParseRequest.call(payload: params, format: request.content_type)
    if parsed_reservation[:errors].present?
      result = {errors: parsed_reservation[:errors], status: 400}
    else
      @reservation = Reservation.create(reservation_params(parsed_reservation[:reservation]))
      if @reservation.errors.present?
        result = { error: @reservation.errors.full_messages.join(", "), status: 400}
      else
        result = { success: {reservation: @reservation, guest: @reservation.guest }, status: 200}
      end
    end

    render json: result
  end

  private
    def reservation_params(parsed_reservation)
      ActionController::Parameters.new(parsed_reservation).permit(:currency, :reservation_code, :status, :start_date, :end_date, :no_of_nights,
                                          :no_of_guests, :no_of_infants, :no_of_adults, :no_of_children, :total_price,
                                          :payout_amt, :security_price, :guest_id,
                                            guest_attributes: [:email, :first_name, :last_name, phone_numbers: []])
    end

    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

end
