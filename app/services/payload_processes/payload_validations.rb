class PayloadProcesses::PayloadValidations

  def initialize(arr, error_msg)
    @errors = arr
    @error_msg = error_msg
  end

  def self.add_error(arr, error_msg)
    new(arr, error_msg).add_error
  end

  def add_error
    begin
      @errors.push(@error_msg)
    rescue
      @errors = [@error_msg]
    end
  end

  def self.verify_string_presence(str, arr, error_msg)
    return str if str.present?
    self.add_error(arr, error_msg)
    ""
  end

  def self.verify_if_number(num, arr, error_msg)
    return num if num.present? && num.is_valid_num?
    self.add_error(arr, error_msg)
    0
  end

  def self.verify_date(str, arr, error_msg)
    begin
      str.to_date
    rescue ArgumentError
      self.add_error(arr, error_msg)
      ""
    end
  end

  def self.verify_email_format(email, arr, error_msg)
    return email if email.to_s.is_valid_email?
    self.add_error(arr, error_msg)
    ""
  end

  def self.verify_phone_number(phone_nos, arr, error_msg)
    self.add_error(arr, "Phone number cannot be nil.") if phone_nos.blank?
    if phone_nos.present?
      is_valid_format = phone_nos.all? {|phone| phone.to_s.is_valid_phone_num?}
      self.add_error(arr, "Phone number must be in correct format") unless is_valid_format
    end

    phone_nos
  end
end
