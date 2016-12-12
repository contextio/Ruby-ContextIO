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
    url = "/2.0/accounts/#{account_id}/contacts/#{email}/files"
    Files.fetch(connection,
                account_id,
                url,
                email,
                method)

  end

  def messages(email = nil, method = :get)
    url = "/2.0/accounts/#{account_id}/contacts/#{email}/messages"
    Messages.fetch(connection,
                   account_id,
                   url,
                   email,
                   method)
  end
end
