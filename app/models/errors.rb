module Errors
  class HometimeError < StandardError
    class << self
      attr_accessor :default_message, :default_http_status, :default_code
    end

    attr_reader :http_status, :code

    def initialize(message = nil, http_status: nil, code: nil)
      super(message || self.class.default_message)
      @http_status = http_status || self.class.default_http_status || 500
      @code = code || self.class.default_code || 99_999
    end
  end

  class InternalServerError < HometimeError
    self.default_message = 'Internal server error'
    self.default_http_status = 500
    self.default_code = 99_999
  end

  class UnparseablePayloadError < HometimeError
    self.default_message = 'Failed to parse payload'
    self.default_http_status = 400
    self.default_code = 11_001
  end
end
