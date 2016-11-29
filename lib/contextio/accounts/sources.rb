class Sources
  private
  attr_reader :request

  public
  include RequestHelper
  def initialize(request)
    @request = request
  end

  def self.fetch(connection, account_id, id, method)
    Sources.new(Request.new(connection,
                            method,
                            "/2.0/accounts/#{account_id}/sources/#{id}"))
  end
end
