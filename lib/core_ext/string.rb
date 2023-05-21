class String
  def is_valid_num?
    begin
      Float(self)
      true
    rescue ArgumentError, TypeError
       false
    end
  end

  def is_valid_currency?
    curr = /^\$?\d{1,3}(,\d{3})*(\.\d{2})?$/
    curr.match?(self)
  end

  def is_valid_email?
    email_reg = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    email_reg.match?(self)
  end

  def is_valid_phone_num?
    if is_valid_num?
      begin self.count == 12
        self[0] == 6 && self[1] == 3
      rescue
        false
      end
    else
      return false
    end
  end

end
