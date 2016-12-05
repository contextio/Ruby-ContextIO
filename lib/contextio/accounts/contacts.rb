class Contacts
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

  def files(email = nil, method = :get)
    Files.contacts_fetch(connection,
                         account_id,
                         email,
                         method)

  end

  def messages(email = nil, method = :get)
    Messages.contacts_fetch(connection,
                            account_id,
                            email,
                            method)
  end

  def self.fetch(connection, account_id, email, method)
    Contacts.new(Request.new(connection,
                             method,
                             "/2.0/accounts/#{account_id}/contacts/#{email}"),
                             connection,
                             account_id)
  end
end
