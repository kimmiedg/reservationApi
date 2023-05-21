module VerificationsHelper
  def add_error(error)
    @errors[:errors].push(error)
  end
end
