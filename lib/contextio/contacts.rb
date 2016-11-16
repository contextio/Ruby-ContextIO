class Contacts
  attr_reader :response, :raw_response
  def initialize(response, raw_response, success = true)
    @response = response
    @raw_response = raw_response
    @success = success
  end
end
