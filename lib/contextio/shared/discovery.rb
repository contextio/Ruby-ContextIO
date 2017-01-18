module ContextIO
  class Discovery
    include ContextIO::CallHelpers
    DISCOVERY_READERS = %I(email found resource_url type imap documentation)

    private
    attr_reader :parent

    public
    attr_reader :status, :success, :connection, :response, *DISCOVERY_READERS
    def initialize(parent:,
                   email:,
                   response: nil,
                   status: nil,
                   success: nil)
      @parent = parent
      @connection = parent.connection
      @email = email
      @response = response
      @status = status
      @success =  success
    end

    def call_url
      "#{parent.call_url}/discovery?email=#{email}&source_type=IMAP"
    end
  end
end
