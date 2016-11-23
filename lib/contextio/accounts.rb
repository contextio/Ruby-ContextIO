
require "contextio/accounts/connect_tokens"
require "contextio/accounts/contacts"
require "contextio/accounts/email_addresses"
require "contextio/accounts/files"
require "contextio/accounts/messages"
require "contextio/accounts/sources"
require "contextio/accounts/sync"
require "contextio/accounts/threads"
require "contextio/accounts/webhooks"
require "contextio/response_utility"

ERROR_STRING = "This method can only be called on a single account".freeze

class Accounts
  attr_reader :parsed_response_body, :raw_response_body, :status, :success, :connection
  def initialize(parsed_response_body,
                 raw_response_body,
                 status,
                 success = true,
                 connection = nil)
    @parsed_response_body = parsed_response_body
    @raw_response_body = raw_response_body
    @status = status
    @success = success
    @connection = connection
  end

  def connect_tokens(id = nil, method = :get)
    if id
      craft_response(id, method, "ConnectTokens", "connect_tokens", connection)
    else
      craft_response(id, method, "ConnectTokens", "connect_tokens")
    end
  end

  def contacts(email = nil, method = :get)
    if email
      craft_response(email, method, "Contacts", "contacts", connection)
    else
      craft_response(email, method, "Contacts", "contacts")
    end
  end

  def email_addresses(email = nil, method = :get)
    if email
      craft_response(email, method, "EmailAddresses", "email_addresses", connection)
    else
      craft_response(email, method, "EmailAddresses", "email_addresses")
    end
  end

  def files(id = nil, method = :get)
    if id
      craft_response(id, method, "Files", "files", connection)
    else
      craft_response(id, method, "Files", "files")
    end
  end

  def messages(id = nil, method = :get)
    craft_response(id, method, "Messages", "messages")
  end

  def sources(id = nil, method = :get)
    craft_response(id, method, "Sources", "sources")
  end

  def sync(id = nil, method = :get)
    craft_response(id, method, "Sync", "sync")
  end

  def threads(id = nil, method = :get)
    craft_response(id, method, "Threads", "threads")
  end

  def webhooks(id = nil, method = :get)
    craft_response(id, method, "Webhooks", "webhooks")
  end
  #TODO: Remove resource, add a hash e.g. { Webhooks: Webhooks }
  def craft_response(identifier, method, klass, resource, conn = nil)
    account_id = recover_from_type_error
    klass = Object.const_get(klass)
    if account_id == ERROR_STRING
      #TODO: Throw an error
      klass.new(ERROR_STRING, ERROR_STRING, nil, false)
    elsif conn
      klass.fetch(conn,
                  account_id,
                  identifier,
                  method)
    else
      response = ResponseUtility.new(connection, method, "/2.0/accounts/#{account_id}/#{resource}")
      klass.new(response.parsed_response_body,
                response.raw_response_body,
                response.status,
                response.success)
    end
  end

  def recover_from_type_error
    begin
      account_id = self.parsed_response_body["id"]
    rescue
      return ERROR_STRING
    end
    account_id
  end

  def success?
    @success
  end

  def self.fetch(connection, id = nil, method = :get)
    if id
      response = ResponseUtility.new(connection, method, "/2.0/accounts/#{id}")
      Accounts.new(response.parsed_response_body,
                   response.raw_response_body,
                   response.status,
                   response.success,
                   connection)
    else
      response = ResponseUtility.new(connection, method, "/2.0/accounts")
      Accounts.new(response.parsed_response_body,
                   response.raw_response_body,
                   response.status,
                   response.success,
                   connection)
    end
  end
end
