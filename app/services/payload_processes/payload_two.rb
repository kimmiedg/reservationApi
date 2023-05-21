require 'core_ext/string'
class PayloadProcesses::PayloadTwo

  def initialize(payload:)
    @payload = payload
    @errors = {errors: []}
  end

  def self.parse(payload:)
    new(payload: payload).parse
  end

  def parse
    @payload = @payload["reservation"]
    @payload = @payload.present? ? reformat_payload : {error: "Unsupported format"}
    @payload = @errors[:errors].present? ? @errors : @payload

    @payload
  end

  private
    def reformat_payload
      {reservation: {reservation_code: reservation_code, start_date: start_date, end_date: end_date, payout_amt: payout_amt,
                            no_of_guests: no_of_guests, no_of_infants: no_of_infants, no_of_children: no_of_children, no_of_adults: no_of_adults,
                            status: status, security_price: security_price, currency: curr, nights: nights, total_price: total_price,
                            guest_attributes: {email: email, first_name: first_name, last_name: last_name, phone_numbers: phone_numbers}}}
    end

    def edd_error(error)
      @errors["error"].push(error)
    end

    def verify_string_presence(str, error_msg)
      if str.present?
        str
      else
        add_error(error_msg)
        ""
      end
    end

    def reservation_code
      verify_string_presence(@payload["code"], "Reservation Code must be present.")
    end

    def start_date
      a = @payload["start_date"]

      a.to_date ? a.to_date : add_error("Invalid Start Date")
    end

    def end_date
      a = @payload["end_date"]
      a.to_date ? a.to_date : add_error("Invalid End Date")
    end

    def payout_amt
      a = @payload["expected_payout_amount"]
      a.is_valid_num? ? a : add_error("Payout Amount must be numeric")
    end

    def no_of_guests
      a = @payload["guest_details"]["localized_description"][0]
      a.is_valid_num? ? a : add_error("No of guest must be included")
    end

    def no_of_infants
      a = @payload["guest_details"]["number_of_infants"].to_s
      a.is_valid_num? ? a : add_error("No of infants must be numeric")
    end

    def no_of_children
      a=@payload["guest_details"]["number_of_children"].to_s
      a.is_valid_num? ? a : add_error("No of children must be numeric")
    end

    def no_of_adults
      a = @payload["guest_details"]["number_of_adults"].to_s
      a.is_valid_num? ? a : add_error("No of adults must be numeric")
    end

    def status
      a = @payload["status_type"]
      a.present? ? a : add_error("Status must not be empty")
    end

    def security_price
      a = @payload["listing_security_price_accurate"]
      a.is_valid_num? ? a : add_error("Security price must be numeric")
    end

    def curr
      a = @payload["host_currency"].to_s
      a.present? ? a : add_error("Must be a valid currency.")
    end

    def nights
      a = @payload["nights"].to_s
      a.is_valid_num? ? a : add_error("No. of nights must be numeric")
    end

    def total_price
      a = @payload["total_paid_amount_accurate"].to_s
      a.is_valid_num? ? a : add_error("Total price must be numeric")
    end

    def email
      a = @payload["guest_email"].to_s
      a.is_valid_email? ? a : add_error("Email is invalid.")
    end

    def first_name
      a = @payload["guest_first_name"]
      a.present? ? a : add_error("First Name must be present")
    end

    def last_name
      a = @payload["guest_last_name"]
      a.present? ? a : add_error("Last Name must be present")
    end

    def phone_numbers
      phone_nos = @payload["guest_phone_numbers"]
      if phone_nos.all? {|phone| phone.is_valid_phone_num? }
        add_error("Phone number must be in correct format")
      end

      phone_nos
    end

end
