class Contacts
  private
  attr_reader :connection, :account_id, :email

  public
  include RequestHelper
  attr_reader :response, :status, :success
  def initialize(request, connection, account_id, email = nil)
    @response = request.response
    @status = request.status
    @success =  request.success
    @connection = connection
    @account_id = account_id
    @email = email
  end

  def files(email_address = nil, method = :get)
    Files.new(Request.new(connection,
                          method,
                          "/2.0/accounts/#{account_id}/contacts/#{email}/files"),
              connection,
              account_id)

  end

  def messages(email_address = nil, method = :get)
    Messages.new(Request.new(connection,
                             method,
                             "/2.0/accounts/#{account_id}/contacts/#{email}/messages"),
                 connection,
                 account_id)
  end
end
