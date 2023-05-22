require 'json'
class ParseRequest
  def initialize(payload:, format:)
    @payload = payload
    @format = format
  end

  def self.call(payload:, format:)
    new(payload: payload, format: format).call
  end

  def call
    parsed_data = {errors: "Must be JSON request format."}
    if @format == "application/json"
      parsed_data = process_payload
    end

    return parsed_data
  end

  private

    def process_payload
      if @payload.key?("reservation")
        parsed_data = PayloadProcesses::PayloadTwo.parse(payload: @payload)
      else
        parsed_data = PayloadProcesses::PayloadOne.parse(payload: @payload)
      end

      return parsed_data
    end


end
