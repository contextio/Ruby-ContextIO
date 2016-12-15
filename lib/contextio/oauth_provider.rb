class OauthProvider
  private
  attr_reader :connection

  public
  include RequestHelper
  attr_reader :response, :status, :success, :token
  def initialize(connection, response, status, success, token)
    @connection = connection
    @response = response
    @status = status
    @success = success
    @token = token
  end

  def get
    Request.new(connection, :get, "/2.0/oauth_providers/#{token}")
  end
end
