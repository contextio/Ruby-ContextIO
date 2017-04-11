module ContextIO
  class OauthProvider
    include ContextIO::CallHelpers
    OAUTH_READERS = %I(type provider_consumer_key provider_consumer_secret resource_url)
    private
    attr_reader :connection

    public
    attr_accessor :api_call_made
    attr_reader :status, :parent, :success, :key, *OAUTH_READERS
    def initialize(parent:,
                   identifier: nil,
                   response: nil,
                   status: nil,
                   success: nil,
                   api_call_made: nil)
      @parent = parent
      @connection = parent.connection
      @response = response
      @status = status
      @success = success
      @key = identifier
      @api_call_made = api_call_made
      if response
        parse_response(response)
      end
    end

    def call_url
      build_url("oauth_providers", key)
    end
  end
end
