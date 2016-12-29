module ContextIO
  class OauthProvider < BaseClass
    OAUTH_ATTRS = %I(type provider_consumer_key provider_consumer_secret resource_url)
    private
    attr_reader :parent

    public
    include CollectionHelper
    attr_reader :status, :success, :token, *OAUTH_ATTRS
    def initialize(parent:,
                  token: nil,
                  response: nil,
                  status: nil,
                  success: nil)
      @parent = parent
      @response = response
      @status = status
      @success = success
      @token = token
      if response
        response.each { |k,v| instance_variable_set("@#{k}", v) }
      end
    end

    def get
      request = Request.new(parent.connection, :get, "/2.0/oauth_providers/#{key}")
      OauthProvider.new(parent,
                        key,
                        request.response,
                        request.status,
                        request.success)
    end
  end
end
