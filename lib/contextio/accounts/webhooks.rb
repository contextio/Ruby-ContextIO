class Webhooks
  private
  attr_reader :connection, :account_id, :webhook_id

  public
  include RequestHelper
  attr_reader :response, :status, :success
  def initialize(request, connection, account_id, webhook_id)
    @response = request.response
    @status = request.status
    @success =  request.success
    @connection = connection
    @account_id = account_id
    @webhook_id = webhook_id
  end

  def self.fetch(connection, account_id, id, method)
    Webhooks.new(Request.new(connection,
                             method,
                             "/2.0/accounts/#{account_id}/webhooks/#{id}"),
                             connection,
                             account_id)
  end
end
