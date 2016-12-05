class Files
  private
  attr_reader  :connection, :account_id

  public
  include RequestHelper
  attr_reader :response, :status, :success
  def initialize(request, connection, account_id)
    @response = request.response
    @status = request.status
    @success =  request.success
    @connection = connection
    @account_id = account_id
  end

  def self.fetch(connection,
                 account_id,
                 url,
                 email,
                 method)
    Files.new(Request.new(connection, method, url), connection, account_id)
  end
end
