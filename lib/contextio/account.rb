ERROR_STRING = "This method can only be called on a single account".freeze
require "contextio/utilities/request_helper"

ATTRS = %I(username created suspended email_addresses first_name last_name
        password_expired sources resource_url)

class Account
  private
  attr_reader :context_io

  public
  include RequestHelper
  attr_reader :account_id, :success, :status, *ATTRS
  def initialize(context_io,
                 account_id,
                 response = nil,
                 status = nil,
                 success = nil)
    @context_io = context_io
    @account_id = account_id
    @status = status
    @success = success
    if response
      response.each { |k,v| instance_variable_set("@#{k}", v) }
    end
  end

  def get
    request = Request.new(context_io.connection, :get, "/2.0/accounts/#{account_id}")
    Account.new(context_io,
                account_id,
                request.response,
                request.status,
                request.success)
  end

  def connect_tokens(token_id: nil, method: :get)
    if token_id
      craft_response(token_id, method, ConnectTokens, "connect_tokens")
    else
      craft_response(nil, method, ConnectTokens, "connect_tokens")
    end
  end

  def contacts(email: nil, method: :get)
    if email
      craft_response(email, method, Contacts, "contacts")
    else
      craft_response(nil, method, Contacts, "contacts")
    end
  end

  def email_addresses(email: nil, method: :get)
    if email
      craft_response(email, method, EmailAddresses, "email_addresses")
    else
      craft_response(nil, method, EmailAddresses, "email_addresses")
    end
  end

  def files(id: nil, method: :get)
    if id
      craft_response(id, method, Files, "files")
    else
      craft_response(id, method, Files, "files")
    end
  end

  def messages(id: nil, method: :get)
    craft_response(id, method, Messages, "messages")
  end

  def sources(id: nil, method: :get)
    craft_response(id, method, Sources, "sources")
  end

  def sync(method: :get)
    Sync.new(Request.new(connection, method, "/2.0/accounts/#{account_id}/sync"))
  end

  def threads(id: nil, method: :get)
    craft_response(id, method, Threads, "threads")
  end

  def webhooks(id: nil, method: :get)
    craft_response(id, method, Webhooks, "webhooks")
  end

  #TODO: Remove resource, add a hash e.g. { Webhooks: Webhooks }
  def craft_response(identifier, method, klass, resource)
    if account_id == nil
      #TODO: Throw an error
      FailedRequest.new(ERROR_STRING)
    elsif identifier
      klass.new(Request.new(connection,
                            method,
                            "/2.0/accounts/#{account_id}/#{klass.to_s.downcase}/#{identifier}"),
                  connection,
                  account_id,
                  identifier)
    else
      klass.new(CollectionRequest.new(connection,
                            method,
                            "/2.0/accounts/#{account_id}/#{resource}",
                            klass,
                            account_id),
                connection,
                account_id)
    end
  end
end
