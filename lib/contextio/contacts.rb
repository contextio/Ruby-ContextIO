class Contacts
  attr_reader :response, :raw_response
  def initialize(response, raw_response)
    @response = response
    @raw_response = raw_response
  end
end
