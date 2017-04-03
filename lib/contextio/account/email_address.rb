module ContextIO
  class EmailAddress
    include ContextIO::CallHelpers
    EMAIL_ATTRS = %I(validated primary resource_url)

    private
    attr_reader :parent

    public
    attr_accessor :api_call_made
    attr_reader :response, :status, :connection, :success, :email, *EMAIL_ATTRS
    def initialize(parent:,
                   identifier: nil,
                   response: nil,
                   status: nil,
                   success: nil,
                   api_call_made: nil)
      @parent = parent
      @connection = parent.connection
      @email = identifier
      @status = status
      @success = success
      @api_call_made = api_call_made
      if response
        parse_response(response)
      end
    end

    def call_url
      build_url("email_addresses", email)
    end
  end
end
