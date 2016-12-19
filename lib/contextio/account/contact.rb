class Contact
  CONTACT_ATTRS =  %I(emails name thumbnail last_received last_sent count sent_count
                     received_count sent_from_account_count)

  private
  attr_reader :context_io

  public
  include RequestHelper
  attr_reader :response, :status, :success, :account_id, :email, *CONTACT_ATTRS
  def initialize(context_io:,
                 account_id:,
                 identifier:,
                 response: nil,
                 status: nil,
                 success: nil)
    @context_io = context_io
    @account_id = account_id
    @email = identifier
    @status = status
    @success =  success
    if response
      response.each { |k,v| instance_variable_set("@#{k}", v) }
    end
  end

  def get
    request = Request.new(context_io.connection, :get, "/2.0/accounts/#{account_id}/contacts/#{email}")
    Contact.new(context_io: context_io,
                account_id: account_id,
                identifier: email,
                response: request.response,
                status: request.status,
                success: request.success)
  end

  def get_files
    request = Request.new(context_io.connection, :get, "/2.0/accounts/#{account_id}/contacts/#{email}/files")
    collection_return(request, context_io, Files, "file_id", account_id)
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
