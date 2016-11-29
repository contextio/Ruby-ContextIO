class Contacts
  private
  attr_reader  :request, :connection, :account_id

  public
  include RequestHelper
  def initialize(request, connection = nil, account_id = nil)
    @request = request
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
