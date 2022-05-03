class Context
  attr_reader :request_id

  def initialize
    @request_id = SecureRandom.uuid
  end
end
