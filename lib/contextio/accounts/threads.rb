class Threads
  private
  attr_reader :connection

  public
  include RequestHelper
  attr_reader :response, :status, :success
  def initialize(request, connection = nil)
    @response = request.response
    @status = request.status
    @success =  request.success
    @connection = connection
  end

  def self.fetch(connection, account_id, id, method)
    Threads.new(Request.new(connection,
                            method,
                            "/2.0/accounts/#{account_id}/threads/#{id}"))
  end
end
