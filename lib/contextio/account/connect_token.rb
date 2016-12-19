class ConnectToken
  CONNECT_ATTRS = %I(email created used expires callback_url first_name last_name account)
  private
  attr_reader :context_io

  public
  include RequestHelper
  attr_reader :token, :account_id, :success, :status, *CONNECT_ATTRS
  def initialize(context_io:,
                 account_id:,
                 identifier:,
                 response: nil,
                 status: nil,
                 success: nil)
    @context_io = context_io
    @account_id = account_id
    @token = identifier
    @response = response
    @status = status
    @success =  success
    if response
      response.each { |k,v| instance_variable_set("@#{k}", v) }
    end
  end

  def get
    request = Request.new(context_io.connection, :get, "/2.0/accounts/#{account_id}/connect_tokens/#{token}")
    ConnectToken.new(context_io: context_io,
                     account_id: account_id,
                     identifier: token,
                     response: request.response,
                     status: request.status,
                     success: request.success)
  end

  def self.fetch(connection, id: nil, method: :get)
      ConnectTokens.new(Request.new(context_io.connection,
                                    method,
                                    "/2.0/connect_tokens/#{id}"),
                                    connection)
  end
end
