class ConnectTokens
  attr_reader :response, :raw_response, :success
  def initialize(response, raw_response, success = true)
    @response = response
    @raw_response = raw_response
    @success = success
  end

  def success?
    @success
  end
end