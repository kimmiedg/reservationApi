require 'core_ext/string'
class PayloadProcesses::PayloadOne

  def initialize(payload:)
    @payload = payload
    @errors = {errors: []}
  end

  def self.parse(payload:)
    new(payload: payload).parse
  end

  def parse
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

    def add_error(error_msg)
      PayloadProcesses::PayloadValidations.add_error(@errors[:errors], error_msg)
    end

    def verify_string_presence(str, error_msg)
      PayloadProcesses::PayloadValidations.verify_string_presence(str, @errors[:errors], error_msg)
    end

    def verify_if_number(num, error_msg)
      PayloadProcesses::PayloadValidations.verify_if_number(num, @errors[:errors], error_msg)
    end

    def verify_date(str, error_msg)
      PayloadProcesses::PayloadValidations.verify_date(str, @errors[:errors], error_msg)
    end

    def reservation_code
      verify_string_presence(@payload["reservation_code"].to_s, "Reservation Code must be present.")
    end

    def start_date
      verify_date(@payload["start_date"], "Invalid Start Date")
    end

    def end_date
      verify_date(@payload["end_date"], "Invalid End Date")
    end

    def payout_amt
      verify_if_number(@payload["payout_price"], "Payout Amount must be numeric")
    end

    def no_of_guests
      verify_if_number(@payload["guests"].to_s, "Number of guests must be numeric")
    end

    def no_of_infants
      verify_if_number(@payload["infants"].to_s, "Number of infants must be numeric")
    end

    def no_of_children
      verify_if_number(@payload["children"].to_s, "Number of children must be numeric")
    end

    def no_of_adults
      verify_if_number(@payload["adults"].to_s, "Number of adults must be numeric")
    end

    def status
      verify_string_presence(@payload["status"], "Status must not be empty")
    end

    def security_price
      verify_if_number(@payload["security_price"], "Security price must be numeric")
    end

    def currency
      verify_string_presence(@payload["currency"], "Must be a valid currency.")
    end

    def nights
      verify_if_number(@payload["nights"].to_s, "No. of nights must be numeric")
    end

    def total_price
      verify_if_number(@payload["total_price"].to_s, "Total price must be numeric")
    end

    def email
      PayloadProcesses::PayloadValidations.verify_email_format(@payload["guest"]["email"], @errors[:errors], "Email is invalid.")
    end

    def first_name
      verify_string_presence(@payload["guest"]["first_name"], "First Name must be present")
    end

    def last_name
      verify_string_presence(@payload["guest"]["last_name"], "Last Name must be present")
    end

    def phone_numbers
      PayloadProcesses::PayloadValidations.verify_phone_number(@payload["guest"]["phone"].split(","), @errors[:errors], "Phone number must be in correct format")
    end

end
