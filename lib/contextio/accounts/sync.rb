class Sync
  private
  attr_reader :request

  public
  include RequestHelper
  attr_reader :response, :status, :success
  def initialize(request)
    @response = request.response
    @status = request.status
    @success =  request.success
  end

  def self.fetch(connection, account_id, id, method)
    Sync.new(Request.new(connection,
                         method,
                         "/2.0/accounts/#{account_id}/sync/#{id}"))
  end
end
