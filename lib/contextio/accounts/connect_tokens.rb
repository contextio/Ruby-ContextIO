class ConnectTokens
  attr_reader :response, :success, :status
  def initialize(response, status, success = true)
    @response = response
    @status = status
    @success = success
  end

  def success?
    @success
  end

  def self.fetch(connection, account_id, id, method = :get)
    request = Request.new(connection,
                          method,
                          "/2.0/accounts/#{account_id}/connect_tokens/#{id}")
    ConnectTokens.new(request.response,
                      request.status,
                      request.success)
  end
end
