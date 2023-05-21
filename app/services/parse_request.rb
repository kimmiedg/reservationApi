require 'json'
class ParseRequest
  def initialize(payload:)
    @payload = payload
    @format = format
  end

  def self.call(payload:, format:)
    new(payload: payload).call
  end

  def call

  end

  private
    def is_json_format
    end

    def process_payload
      # parse_data = {}
      # if @payload["request"].present?
      #   parsed_data = PayloadProcesses::PayloadOne.call(payload: @payload)
      # else
      #   #parse_date = PayloadProcesses::PayloadTwo.call(payload: @payload)
      # end
      #
      # return parsed_data
    end

end
