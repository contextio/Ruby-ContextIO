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

  def files(email_address: nil, method: :get)
    Files.new(CollectionRequest.new(connection,
                                    method,
                                    "/2.0/accounts/#{account_id}/contacts/#{email || email_address}/files",
                                    Files,
                                    account_id),
              connection,
              account_id,
              "Collection")

  end

  def messages(email_address: nil, method: :get)
    Messages.new(CollectionRequest.new(connection,
                                       method,
                                       "/2.0/accounts/#{account_id}/contacts/#{email || email_address}/messages",
                                       Messages,
                                       account_id),
                 connection,
                 account_id,
                 "Messages")
  end

  def threads(email_address: nil, method: :get)
    Request.new(connection,
                method,
                "2.0/accounts/#{account_id}/contacts/#{email || email_address}/threads")
  end
end
