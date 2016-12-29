module ContextIO
  class ConnectToken < BaseClass
    CONNECT_READERS = %I(email source_callback_url source_raw_file_list created
                         used expires status_callback_url first_name last_name account
                         resource_url server_label callback_url)
    private
    attr_reader :parent

    public
    include CollectionHelper
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

    def get
      call_api
    end
  end
end
