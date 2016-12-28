require "contextio/utilities/request_helper"

ACCOUNT_ATTRS = %I(username created suspended email_addresses first_name last_name
                   password_expired sources resource_url)

class Account
  private
  attr_reader :parent

  public
  include RequestHelper
  attr_reader :id, :success, :status, *ACCOUNT_ATTRS
  def initialize(parent:,
                 identifier: nil,
                 response: nil,
                 status: nil,
                 success: nil)
    @parent = parent
    @id = identifier
    @status = status
    @success = success
    #TODO: Rewrite the object with get, isntead of returning new object
    if response
      response.each { |k,v| instance_variable_set("@#{k}", v) }
    end
  end

  def get
    request = Request.new(parent.connection, :get, "/2.0/accounts/#{id}")
    Account.new(parent: parent,
                identifier: id,
                response: request.response,
                status: request.status,
                success: request.success)
  end

  def get_connect_tokens
    request = Request.new(parent.connection, :get, "/2.0/accounts/#{id}/connect_tokens")
    collection_return(request, parent, ConnectToken, id)
  end

  def get_contacts
    request = Request.new(parent.connection, :get, "/2.0/accounts/#{id}/contacts")
    contact_collection_return(request, parent, id)
  end

  def get_email_addresses
    request = Request.new(parent.connection, :get, "/2.0/accounts/#{id}/email_addresses")
    collection_return(request, parent, EmailAddress,id)
  end

  def get_files
    request = Request.new(parent.connection, :get, "/2.0/accounts/#{id}/files")
    collection_return(request, parent, Files, id)
  end
end
