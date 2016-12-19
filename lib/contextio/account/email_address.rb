class EmailAddress
  private
  attr_reader :context_io

  public
  include RequestHelper
  attr_reader :response, :status, :success, :account_id, :email
  def initialize(context_io:,
                 account_id:,
                 identifier:,
                 response: nil,
                 status: nil,
                 success: nil)
    @context_io = context_io
    @account_id = account_id
    @email = identifier
    @response = response
    @status = status
    @success =  success
  end

  def get
    request = Request.new(context_io.connection, :get, "/2.0/accounts/#{account_id}/email_addresses/#{email}")
    EmailAddress.new(context_io: context_io,
                     account_id: account_id,
                     identifier: email,
                     response: request.response,
                     status: request.status,
                     success: request.success)
  end

  def self.fetch(connection, account_id, id, method)
    EmailAddresses.new(Request.new(connection,
                                   method,
                                   "/2.0/accounts/#{account_id}/email_addresses/#{id}"),
                                   connection,
                                   account_id)
  end
end
