class Threads
  private
  attr_reader :request

  public
  include RequestHelper
  def initialize(response)
    @request = request
  end

  def self.fetch(connection, account_id, id, method)
    Threads.new(Request.new(connection,
                            method,
                            "/2.0/accounts/#{account_id}/threads/#{id}"))
  end
end
