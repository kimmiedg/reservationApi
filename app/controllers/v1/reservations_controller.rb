class V1::ReservationsController < ApplicationController
  before_action :set_reservation, only: [:update, :show, :destroy]
  before_action :parse_payload, only: [:create, :update]

  def create
    @reservation = Reservation.create(reservation_params(@payload[:reservation])) if @payload.present? && @payload.key?(:reservation) || @payload.key?("reservation")
    render json: process_action_payload
  end

  def update
    @reservation.update(reservation_params(@payload[:reservation]))
    render json: process_action_payload
  end

  def destroy
    if @reservation.destroy()
      render json: {success: "Successfully deleted.", status: 200}
    else
      render json: {error: @reservation.errors.full_messages.join(", "), status: 400}
    end
  end

  def show
    render json: { reservation: @reservation, guest: @reservation.guest, status: 200}
  end

  private


    def reservation_params(parsed_reservation)
      ActionController::Parameters.new(parsed_reservation).permit(:currency, :reservation_code, :status, :start_date, :end_date, :no_of_nights,
                                          :no_of_guests, :no_of_infants, :no_of_adults, :no_of_children, :total_price,
                                          :payout_amt, :security_price, :guest_id,
                                            guest_attributes: [:id, :email, :first_name, :last_name, phone_numbers: []])
    end

    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    def parse_payload
      return { errors: @payload[:errors], status: 400 } if @payload.present? && @payload.key?("errors")
      begin # try catch for incorrect JSON request
        @payload = ParseRequest.call(payload: JSON.parse(request.body.read()), format: request.content_type)
      rescue JSON::ParserError => e
        @payload = { errors: "Bad request. Please check documentation", status: 400}
      end
      @payload
    end

    def process_action_payload
      return @payload if @payload.key?(:errors) || @payload.key?("errors")
      if @reservation.blank?
        result = { errors: "Bad request.", status: 400}
      elsif @reservation.errors.present?
        result = { errors: @reservation.errors.full_messages.join(", "), status: 400}
      else
        result = { reservation: @reservation, guest: @reservation.guest, status: 200}
      end

      result
    end


end
