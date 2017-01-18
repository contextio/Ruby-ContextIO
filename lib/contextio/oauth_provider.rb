module ContextIO
  class OauthProvider
    include ContextIO::CallHelpers
    OAUTH_READERS = %I(type provider_consumer_key provider_consumer_secret resource_url)
    private
    attr_reader :connection

    public
    attr_reader :status, :parent, :success, :key, *OAUTH_READERS
    def initialize(parent:,
                   identifier: nil,
                   response: nil,
                   status: nil,
                   success: nil)
      @parent = parent
      @connection = parent.connection
      @response = response
      @status = status
      @success = success
      @key = identifier
      if response
        parse_response(response)
      end
    end

    def call_url
      build_url("oauth_providers", key)
    end
  end
end
