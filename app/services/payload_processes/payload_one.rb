class PayloadProcesses::PayloadOne
  def intialize(payload:)
    @payload = payload
  end

  def self.call(payload:)
    new(payload: payload).call
  end

  def call

  end

  private
    

end
