class Threads
  private
  attr_reader :connection, :account_id, :thread_id

  public
  include RequestHelper
  attr_reader :response, :status, :success
  def initialize(request, connection, account_id, thread_id = nil)
    @response = request.response
    @status = request.status
    @success =  request.success
    @connection = connection
    @account_id = account_id
    @thread_id = thread_id
  end
end
