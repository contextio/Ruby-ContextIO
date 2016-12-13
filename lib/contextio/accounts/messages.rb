class Messages
  private
  attr_reader :connection, :account_id, :message_id

  public
  include RequestHelper
  attr_reader :response, :status, :success
  def initialize(request, connection, account_id, message_id = nil)
    @response = request.response
    @status = request.status
    @success =  request.success
    @connection = connection
    @account_id = account_id
    @message_id = message_id || response["message_id"]
  end
end
