require "contextio/utilities/request_helper"

ACCOUNT_ATTRS = %I(username created suspended email_addresses first_name last_name
                   password_expired sources resource_url)

class Account
  private
  attr_reader :context_io

  public
  include RequestHelper
  attr_reader :id, :success, :status, *ACCOUNT_ATTRS
  def initialize(context_io:,
                 identifier: nil,
                 response: nil,
                 status: nil,
                 success: nil)
    @context_io = context_io
    @id = identifier
    @status = status
    @success = success
    #TODO: Rewrite the object with get, isntead of returning new object
    if response
      response.each { |k,v| instance_variable_set("@#{k}", v) }
    end
  end

  def get
    request = Request.new(context_io.connection, :get, "/2.0/accounts/#{id}")
    Account.new(context_io: context_io,
                identifier: id,
                response: request.response,
                status: request.status,
                success: request.success)
  end

  def get_connect_tokens
    request = Request.new(context_io.connection, :get, "/2.0/accounts/#{id}/connect_tokens")
    collection_return(request, context_io, ConnectToken, id)
  end

  def get_contacts
    request = Request.new(context_io.connection, :get, "/2.0/accounts/#{id}/contacts")
    contact_collection_return(request, context_io, id)
  end

  def get_email_addresses
    request = Request.new(context_io.connection, :get, "/2.0/accounts/#{id}/email_addresses")
    collection_return(request, context_io, EmailAddress,id)
  end

  def get_files
    request = Request.new(context_io.connection, :get, "/2.0/accounts/#{id}/files")
    collection_return(request, context_io, Files, id)
  end
end
