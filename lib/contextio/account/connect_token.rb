module ContextIO
  class ConnectToken
    CONNECT_READERS = %I(email source_callback_url source_raw_file_list created
                         used expires status_callback_url first_name last_name account
                         resource_url server_label callback_url)
    private
    attr_reader :parent

    public
    include RequestHelper
    attr_reader :token, :connection, :success, :status, *CONNECT_READERS
    def initialize(parent:,
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
      build_url(parent, "connect_tokens", token)
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
