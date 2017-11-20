module ContextIO
  class Discovery
    include ContextIO::CallHelpers
    DISCOVERY_READERS = %I(email found resource_url type imap documentation)

    private
    attr_reader :parent

    public
    attr_accessor :api_call_made
    attr_reader :status, :success, :connection, :response, *DISCOVERY_READERS
    def initialize(parent:,
                   email:,
                   response: nil,
                   status: nil,
                   success: nil,
                   api_call_made: nil)
      @parent = parent
      @connection = parent.connection
      @email = email
      @response = response
      @status = status
      @success = success
      @api_call_made = api_call_made
    end

    def call_url
      "#{parent.call_url}/discovery?email=#{email}"
    end
  end
end
