require "contextio/utilities/request_helper"
class Account
  ACCOUNT_READERS = %I(username created suspended email_addresses first_name last_name
                     password_expired sources resource_url)
  private
  attr_reader :connection, :parent

  public
  include RequestHelper
  attr_reader :id, :success, :status, *ACCOUNT_READERS
  def initialize(parent:,
                 identifier: nil,
                 response: nil,
                 status: nil,
                 success: nil)
    @parent = parent
    @connection = parent.connection
    @id = identifier
    @status = status
    @success = success
    if response
      parse_response(response)
    end
  end

  def call_url
    "#{parent.call_url}/accounts/#{id}"
  end

  def get
    request = Request.new(connection, :get, "#{call_url}")
    parse_response(request.response)
    @status = request.status
    @success = check_success(status)
    self
  end

  def get_connect_tokens
    request = Request.new(connection, :get, "#{call_url}/connect_tokens")
    collection_return(request, self, ConnectToken, id)
  end

  def get_contacts
    request = Request.new(connection, :get, "#{call_url}/contacts")
    contact_collection_return(request, self, id)
  end

  def get_email_addresses
    request = Request.new(connection, :get, "#{call_url}/email_addresses")
    collection_return(request, self, EmailAddress, id)
  end

  def get_files
    request = Request.new(connection, :get, "#{call_url}/files")
    collection_return(request, self, Files, id)
  end
end
