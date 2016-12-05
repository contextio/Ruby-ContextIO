class Contacts
  private
  attr_reader :connection, :account_id

  public
  include RequestHelper
  attr_reader :response, :status, :success
  def initialize(request,
                 connection = nil,
                 account_id = nil
                 )
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

  def self.fetch(connection, account_id, email, method)
    Contacts.new(Request.new(connection,
                             method,
                             "/2.0/accounts/#{account_id}/contacts/#{email}"))
  end
end
