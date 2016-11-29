class EmailAddresses
  private
  attr_reader :request

  public
  include RequestHelper
  def initialize(request)
    @request = request
  end

  def self.fetch(connection, account_id, id, method)
    EmailAddresses.new(Request.new(connection,
                                   method,
                                   "/2.0/accounts/#{account_id}/email_addresses/#{id}"))
  end
end
