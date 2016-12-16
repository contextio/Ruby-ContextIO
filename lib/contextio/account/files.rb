class Files
  private
  attr_reader  :connection, :account_id, :file_id

  public
  include RequestHelper
  attr_reader :response, :status, :success
  def initialize(request, connection, account_id, file_id = nil)
    @response = request.response
    @status = request.status
    @success =  request.success
    @connection = connection
    @account_id = account_id
    @file_id = file_id
  end
end
