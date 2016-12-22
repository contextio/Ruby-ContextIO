class OauthProvider
  OAUTH_ATTRS = %I(type provider_consumer_key provider_consumer_secret resource_url)
  private
  attr_reader :contextio

  public
  include RequestHelper
  attr_reader :status, :success, :token, *OAUTH_ATTRS
  def initialize(context_io:,
                token: nil,
                response: nil,
                status: nil,
                success: nil)
    @context_io = context_io
    @response = response
    @status = status
    @success = success
    @token = token
    if response
      response.each { |k,v| instance_variable_set("@#{k}", v) }
    end
  end

  def get
    request = Request.new(context_io.connection, :get, "/2.0/oauth_providers/#{key}")
    OauthProvider.new(context_io,
                      key,
                      request.response,
                      request.status,
                      request.success)
  end
end
