class ConnectTokens
  private
  attr_reader :request

  public
  include RequestHelper
  def initialize(request)
    @request = request
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
