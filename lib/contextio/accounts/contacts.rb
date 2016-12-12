class Contacts
  private
  attr_reader :connection, :account_id, :email

  public
  include RequestHelper
  attr_reader :response, :status, :success
  def initialize(request, connection, account_id, email)
    @response = request.response
    @status = request.status
    @success =  request.success
    @connection = connection
    @account_id = account_id
    @email = email
  end

  def files(email = nil, method = :get)
    Files.new(Request.new(connection,
                          method,
                          "/2.0/accounts/#{account_id}/contacts/#{email}/files",
                          Files,
                          account_id),
              connection,
              account_id)

  end

  def messages(email = nil, method = :get)
    Messages.new(Request.new(connection,
                             method,
                             "/2.0/accounts/#{account_id}/contacts/#{email}/messages",
                             Messages,
                             account_id),
                 connection,
                 account_id)
  end
end
