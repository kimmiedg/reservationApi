class V1::ReservationsController < ApplicationController
  before_action :set_reservation, only: [:index, :update, :show, :delete]

  def create
    result = {error: "JSON is the only accepted format.", status: 400}
    if request.content_type == "application/json"
      reservation = ParseRequest.call(payload: params)
      binding.pry
      # if Reservation.create()
    end
    render json: result
  end

  private
    def reservation_params
      params.require(:reservation).permit(:currency, :reservation_code, :status, :start_date, :end_date, :no_of_nights,
                                          :no_of_guests, :no_of_infants, :no_of_adults, :no_of_children, :total_price,
                                          :payout_amt, :security_price, :guest_id,
                                            guest_attributes: [:id, :email, :first_name, :last_name, :phone_numbers])
    end

    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

end
