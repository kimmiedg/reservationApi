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
      parse_data = {}
      if @payload["reservation"].present?
        parsed_data = PayloadProcesses::PayloadTwo.parse(payload: @payload)
      else
        parse_date = PayloadProcesses::PayloadOne.call(payload: @payload)
      end

      return parsed_data
    end


end
