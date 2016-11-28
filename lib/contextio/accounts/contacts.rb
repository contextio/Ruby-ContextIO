class Contacts
  private
  attr_reader :connection

  public
  attr_reader :response, :status, :success, :account_id
  def initialize(response, status, success = true, connection = nil, account_id = nil)
    @response = response
    @status = status
    @success = success
    @connection = connection
    @account_id = account_id
  end

  def files(email = nil, method = :get)
    Files.contacts_fetch(connection,
                         account_id,
                         email,
                         method)

  end

  def success?
    @success
  end

  def self.fetch(connection, account_id, email, method)
    request = Request.new(connection,
                          method,
                          "/2.0/accounts/#{account_id}/contacts/#{email}")
    Contacts.new(request.response,
                 request.status,
                 request.success,
                 connection,
                 account_id)
  end
end
