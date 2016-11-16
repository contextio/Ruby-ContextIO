require "contextio/accounts/connect_tokens"
require "contextio/accounts/contacts"
require "contextio/accounts/email_addresses"
require "contextio/accounts/files"
require "contextio/accounts/messages"
require "contextio/accounts/sources"
require "contextio/accounts/sync"
require "contextio/accounts/threads"
require "contextio/accounts/webhooks"

require "json"
ERROR_STRING = "This method can only be called on a single account".freeze

class Accounts
  attr_reader :response, :raw_response, :success, :connection
  def initialize(response, raw_response, success = true, connection = nil)
    @response = response
    @raw_response = raw_response
    @success = success
    @connection = connection
  end

  def connect_tokens(id = nil, method = :get)
    craft_response(id, method, "ConnectTokens", "connect_tokens")
  end

  def contacts(id = nil, method = :get)
    craft_response(id, method, "Contacts", "contacts")
  end

  def email_addresses(id = nil, method = :get)
    craft_response(id, method, "EmailAddresses", "email_addresses")
  end

  def files(id = nil, method = :get)
    craft_response(id, method, "Files", "files")
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

  def craft_response(id, method, klass, resource)
    account_id = recover_from_type_error
    klass = Object.const_get(klass)
    if account_id == ERROR_STRING
      klass.new(ERROR_STRING, ERROR_STRING, false)
    else
      raw_response = connection.connect.send(method, "/2.0/accounts/#{account_id}/#{resource}").body
      response = JSON.parse(raw_response)
      klass.new(response, raw_response)
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
      raw_response = connection.connect.send(method, "/2.0/accounts/#{id}").body
      response = JSON.parse(raw_response)
      Accounts.new(response, raw_response, Accounts.invalid_id?(response), connection)
    else
      raw_response = connection.connect.send(method, "/2.0/accounts").body
      response = JSON.parse(raw_response)
      Accounts.new(response, raw_response)
    end
  end

  def self.invalid_id?(response)
    return true if response["value"].nil?
    response["value"].split(" ").last != "invalid"
  end
end
