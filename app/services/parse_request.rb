require 'json'
class ParseRequest
  def initialize(payload:)
    @payload = payload
  end

  def self.call(payload:)
    new(payload: payload).call
  end

  def call
    process_payload
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
