class ConnectTokens
  attr_reader :parsed_response_body, :raw_response_body, :success, :status
  def initialize(parsed_response_body, raw_response_body, status, success = true)
    @parsed_response_body = parsed_response_body
    @raw_response_body = raw_response_body
    @status = status
    @success = success
  end

  def success?
    @success
  end

  def self.fetch(connection, account_id, id, method = :get)
    response = ResponseUtility.new(connection,
                                   method,
                                   "/2.0/accounts/#{account_id}/connect_tokens/#{id}")
    ConnectTokens.new(response.parsed_response_body,
                      response.raw_response_body,
                      response.status,
                      response.success)
  end
end
