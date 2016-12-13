class ConnectTokens
  private
  attr_reader :connection, :account_id, :token_id

  public
  include RequestHelper
  attr_reader :response, :status, :success
  def initialize(request, connection, token_id = nil)
    @response = request.response
    @status = request.status
    @success =  request.success
    @connection = connection
    @token_id = token_id
  end

  def self.fetch(connection, id: nil, method: :get)
      ConnectTokens.new(Request.new(connection,
                                    method,
                                    "/2.0/connect_tokens/#{id}"),
                                    connection)
  end
end
