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
                            status: status, security_price: security_price, currency: currency, no_of_nights: nights, total_price: total_price,
                            guest_attributes: {email: email, first_name: first_name, last_name: last_name, phone_numbers: phone_numbers}}}
    end

    def add_error(error)
      @errors[:errors].push(error)
    end

    def verify_string_presence(str, error_msg)
      if str.present?
        str
      else
        add_error(error_msg)
        ""
      end
    end

    def verify_if_number(num, error_msg)
      if num.present? && num.is_valid_num?
        num
      else
        add_error(error_msg)
        0
      end
    end

    def reservation_code
      verify_string_presence(@payload["code"].to_s, "Reservation Code must be present.")
    end

    def start_date
      begin
        @payload["start_date"].to_date
      rescue ArgumentError
        add_error("Invalid Start Date")
        ""
      end
    end

    def end_date
      begin
        @payload["end_date"].to_date
      rescue ArgumentError
        add_error("Invalid End Date")
        ""
      end
    end

    def payout_amt
      verify_if_number(@payload["expected_payout_amount"], "Payout Amount must be numeric")
    end

    def no_of_guests
      verify_if_number(@payload["guest_details"]["localized_description"][0], "Number of guest must be included")
    end

    def no_of_infants
      verify_if_number(@payload["guest_details"]["number_of_infants"].to_s, "Number of infants must be numeric")
    end

    def no_of_children
      verify_if_number(@payload["guest_details"]["number_of_children"].to_s, "Number of children must be numeric")
    end

    def no_of_adults
      verify_if_number(@payload["guest_details"]["number_of_adults"].to_s, "Number of adults must be numeric")
    end

    def status
      verify_string_presence(@payload["status_type"], "Status must not be empty")
    end

    def security_price
      verify_if_number(@payload["listing_security_price_accurate"], "Security price must be numeric")
    end

    def currency
      verify_string_presence(@payload["host_currency"], "Must be a valid currency.")
    end

    def nights
      verify_if_number(@payload["nights"].to_s, "No. of nights must be numeric")
    end

    def total_price
      verify_if_number(@payload["total_paid_amount_accurate"].to_s, "Total price must be numeric")
    end

    def email
      a = @payload["guest_email"].to_s
      a.is_valid_email? ? a : add_error("Email is invalid.")
    end

    def first_name
      verify_string_presence(@payload["guest_first_name"], "First Name must be present")
    end

    def last_name
      verify_string_presence(@payload["guest_last_name"], "Last Name must be present")
    end

    def phone_numbers
      phone_nos = @payload["guest_phone_numbers"]
      unless phone_nos.all? {|phone| phone.is_valid_phone_num? }
        add_error("Phone number must be in correct format")
      end

      phone_nos
    end

end
