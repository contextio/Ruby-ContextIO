module ContextIO
  class ConnectToken
    include ContextIO::CallHelpers
    CONNECT_READERS = %I(email source_callback_url source_raw_file_list created
                         used expires status_callback_url first_name last_name account
                         resource_url server_label callback_url)
    private
    attr_reader :parent

    public
    attr_reader :token, :connection, :success, :status, :resposne, *CONNECT_READERS
    def initialize(parent:,
                   identifier: nil,
                   response: nil,
                   status: nil,
                   success: nil,
                   api_call_made: nil)
      @parent = parent
      @connection = parent.connection
      @token = identifier
      @response = response
      @status = status
      @success = success
      @api_call_made = api_call_made
      if response
        parse_response(response)
      end
    end

    def call_url
      build_url("connect_tokens", token)
    end

    def get
      call_api
    end
  end
end
