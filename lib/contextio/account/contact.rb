class Contact
  private
  attr_reader :context_io, :account_id, :email

  public
  include RequestHelper
  attr_reader :response, :status, :success
  def initialize(context_io,
                 email,
                 account_id,
                 response = nil,
                 status = nil,
                 success = nil)
    @response = response
    @status = status
    @success =  success
    @context_io = context_io
    @account_id = account_id
    @email = email
  end

  def get
    request = Request.new(context_io.connection, :get, "/2.0/accounts/#{account_id}/contacts/#{email}")
    Contact.new(context_io,
                email,
                account_id,
                request.response,
                request.status,
                request.success)
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
