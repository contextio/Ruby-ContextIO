module ContextIO
  class ConnectToken
    CONNECT_READERS = %I(email created used expires callback_url first_name last_name account)
    private
    attr_reader :parent

    public
    include RequestHelper
    attr_reader :token, :connection, :success, :status, *CONNECT_READERS
    def initialize(parent:,
                   account_id: nil,
                   identifier: nil,
                   response: nil,
                   status: nil,
                   success: nil)
      @parent = parent
      @connection = parent.connection
      @token = identifier
      @response = response
      @status = status
      @success =  success
      if response
        parse_response(response)
      end
    end

    def call_url
      "#{parent.call_url}/connect_tokens/#{token}"
    end

    def get
      request = Request.new(connection, :get, call_url)
      parse_response(request.response)
      @status = request.status
      @success = check_success(status)
      self
    end
  end
end
