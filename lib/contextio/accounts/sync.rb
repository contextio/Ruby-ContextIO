class Sync
  private
  attr_reader :request

  public
  include RequestHelper
  def initialize(request)
    @request = request
  end

  def self.fetch(connection, account_id, id, method)
    request = Request.new(connection,
                          method,
                          "/2.0/accounts/#{account_id}/sync/#{id}")
    Sync.new(request.response,
             request.status,
             request.success)
  end
end
