class EmailAddresses
  private
  attr_reader :connection, :account_id

  public
  include RequestHelper
  attr_reader :response, :status, :success
  def initialize(request, connection, account_id)
    @response = request.response
    @status = request.status
    @success =  request.success
    @connection = connection
    @account_id = account_id
  end

  def self.fetch(connection, account_id, id, method)
    EmailAddresses.new(Request.new(connection,
                                   method,
                                   "/2.0/accounts/#{account_id}/email_addresses/#{id}"),
                                   connection,
                                   account_id)
  end
end
