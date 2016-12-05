ERROR_STRING = "This method can only be called on a single account".freeze
require "contextio/request_helper"

class Accounts
  private
  attr_reader :connection, :account_id

  public
  include RequestHelper
  attr_reader :response, :status, :success
  def initialize(request,
                 connection,
                 account_id = nil)
    @response = request.response
    @status = request.status
    @success =  request.success
    @connection = connection
    @account_id = account_id
  end

  def connect_tokens(id = nil, method = :get)
    if id
      craft_response(id, method, ConnectTokens, "connect_tokens", connection)
    else
      craft_response(id, method, ConnectTokens, "connect_tokens")
    end
  end

  def contacts(email = nil, method = :get)
    if email
      craft_response(email, method, Contacts, "contacts", connection)
    else
      craft_response(email, method, Contacts, "contacts")
    end
  end

  def email_addresses(email = nil, method = :get)
    if email
      craft_response(email, method, EmailAddresses, "email_addresses", connection)
    else
      craft_response(email, method, EmailAddresses, "email_addresses")
    end
  end

  def files(id = nil, method = :get)
    if id
      craft_response(id, method, Files, "files", connection)
    else
      craft_response(id, method, Files, "files")
    end
  end

  def messages(id = nil, method = :get)
    craft_response(id, method, Messages, "messages")
  end

  def sources(id = nil, method = :get)
    craft_response(id, method, Sources, "sources")
  end

  def sync(id = nil, method = :get)
    craft_response(id, method, Sync, "sync")
  end

  def threads(id = nil, method = :get)
    craft_response(id, method, Threads, "threads")
  end

  def webhooks(id = nil, method = :get)
    craft_response(id, method, Webhooks, "webhooks")
  end
  #TODO: Remove resource, add a hash e.g. { Webhooks: Webhooks }
  def craft_response(identifier, method, klass, resource, conn = nil)
    account_id = recover_from_type_error
    if account_id == ERROR_STRING
      #TODO: Throw an error
      FailedRequest.new(ERROR_STRING)
    elsif conn
      klass.fetch(conn,
                  account_id,
                  identifier,
                  method)
    else
      klass.new(Request.new(connection, method, "/2.0/accounts/#{account_id}/#{resource}",
                klass,
                account_id),
                connection,
                account_id)
    end
  end

  def recover_from_type_error
    begin
      account_id = self.response["id"]
    rescue
      return ERROR_STRING
    end
    account_id
  end

  def self.fetch(connection, id = nil, method = :get)
    if id
      Accounts.new(Request.new(connection, method, "/2.0/accounts/#{id}"),
                   connection,
                   id)
    else
      Accounts.new(Request.new(connection, method, "/2.0/accounts", Accounts), connection)
    end
  end
end
