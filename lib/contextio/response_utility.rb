class ResponseUtility
  attr_reader :parsed_response_body, :raw_response_body, :status, :success
  def initialize(connection, method, url)
    response = connection.connect.send(method, url)
    @raw_response_body = response.body
    @status = response.status
    @parsed_response_body = JSON.parse(raw_response_body)
    @success =  check_success?(response.status)
  end

  def check_success?(status)
    status >= 200 && status <= 299
  end
end
