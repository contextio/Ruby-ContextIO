class ConnectTokens
  private
  attr_reader :connection

  public
  include RequestHelper
  attr_reader :response, :status, :success
  def initialize(request, connection = nil)
    @response = request.response
    @status = request.status
    @success =  request.success
    @connection = connection
  end

  def self.fetch(connection, account_id, id, method = :get)
    if id
      ConnectTokens.new(Request.new(connection,
                                    method,
                                    "/2.0/accounts/#{account_id}/connect_tokens/#{id}"))
    end
  end
end
