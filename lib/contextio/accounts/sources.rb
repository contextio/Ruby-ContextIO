class Sources
  private
  attr_reader :connection, :account_id, :label

  public
  include RequestHelper
  attr_reader :response, :status, :success
  def initialize(request, connection, account_id, label = nil)
    @response = request.response
    @status = request.status
    @success =  request.success
    @connection = connection
    @account_id = account_id
    @label = label
  end
end
