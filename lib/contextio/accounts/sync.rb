class Sync
  private
  attr_reader :request

  public
  include RequestHelper
  def initialize(request)
    @request = request
  end

  def self.fetch(connection, account_id, id, method)
    Sync.new(Request.new(connection,
                         method,
                         "/2.0/accounts/#{account_id}/sync/#{id}"))
  end
end
