ERROR_STRING = "This method can only be called on a single account".freeze
require "contextio/utilities/request_helper"

ACCOUNT_ATTRS = %I(username created suspended email_addresses first_name last_name
                   password_expired sources resource_url)

class Account
  private
  attr_reader :context_io

  public
  include RequestHelper
  attr_reader :account_id, :success, :status, *ACCOUNT_ATTRS
  def initialize(context_io:,
                 identifier: nil,
                 response: nil,
                 status: nil,
                 success: nil)
    @context_io = context_io
    @account_id = identifier
    @status = status
    @success = success
    if response
      response.each { |k,v| instance_variable_set("@#{k}", v) }
    end
  end

  def get
    request = Request.new(context_io.connection, :get, "/2.0/accounts/#{account_id}")
    Account.new(context_io: context_io,
                identifier: account_id,
                response: request.response,
                status: request.status,
                success: request.success)
  end

  def get_connect_tokens
    request = Request.new(context_io.connection, :get, "/2.0/accounts/#{account_id}/connect_tokens")
    collection_return(request, context_io, ConnectToken, account_id)
  end

  def get_contacts
    request = Request.new(context_io.connection, :get, "/2.0/accounts/#{account_id}/contacts")
    contact_collection_return(request, context_io, account_id)
  end

  def get_email_addresses
    request = Request.new(context_io.connection, :get, "/2.0/accounts/#{account_id}/email_addresses")
    collection_return(request, context_io, EmailAddress, account_id)
  end
end
