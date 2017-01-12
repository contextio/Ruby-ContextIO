module ContextIO
  class OauthProvider < BaseClass
    OAUTH_READERS = %I(type provider_consumer_key provider_consumer_secret resource_url)
    private
    attr_reader :connection

    public
    attr_reader :status, :parent, :success, :token, *OAUTH_READERS
    def initialize(parent:,
                  token: nil,
                  response: nil,
                  status: nil,
                  success: nil)
      @parent = parent
      @connection = parent.connection
      @response = response
      @status = status
      @success = success
      @token = token
      if response
        parse_response(response)
      end
    end

    def call_url
      build_url("oauth_providers", token)
    end
  end
end
