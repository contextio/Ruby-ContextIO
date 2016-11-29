class Messages
  private
  attr_reader :request

  public
  include RequestHelper
  def initialize(response, status, success = true)
    @request = request
  end

  def self.fetch(connection, account_id, id, method)
    request = Request.new(connection,
                          method,
                          "/2.0/accounts/#{account_id}/messages/#{id}")
    Messages.new(request.response,
                 request.status,
                 request.success)
  end
end
