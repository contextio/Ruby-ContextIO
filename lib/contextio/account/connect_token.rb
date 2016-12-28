module ContextIO
  class ConnectToken
    CONNECT_ATTRS = %I(email created used expires callback_url first_name last_name account)
    private
    attr_reader :parent

    public
    include RequestHelper
    attr_reader :token, :account_id, :success, :status, *CONNECT_ATTRS
    def initialize(parent:,
                   account_id: nil,
                   identifier: nil,
                   response: nil,
                   status: nil,
                   success: nil)
      @parent = parent
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
      request = Request.new(parent.connection, :get, "/2.0/accounts/#{account_id}/connect_tokens/#{token}")
      ConnectToken.new(parent: parent,
                       account_id: account_id,
                       identifier: token,
                       response: request.response,
                       status: request.status,
                       success: request.success)
    end
  end
end
