require "contextio/accounts/connect_tokens"
require "contextio/accounts/contacts"
require "contextio/accounts/email_addresses"
require "contextio/accounts/files"
require "contextio/accounts/messages"
require "contextio/accounts/sources"
require "contextio/accounts/sync"
require "contextio/accounts/threads"
require "contextio/accounts/webhooks"

ERROR_STRING = "This method can only be called on a single account".freeze

class Accounts
  private

  attr_reader :connection

  public

  attr_reader :parsed_response_body, :raw_response_body, :status, :success
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

  def craft_response(id, method, klass, resource, connection = nil)
    account_id = recover_from_type_error
    klass = Object.const_get(klass)
    if account_id == ERROR_STRING
      klass.new(ERROR_STRING, ERROR_STRING, "403", false)
    elsif connection
      klass.fetch(connection,
                  account_id,
                  id,
                  method)
    else
      raw_response = connection.connect.send(method, "/2.0/accounts/#{account_id}/#{resource}")
      status = raw_response.status
      raw_response_body = raw_response_body.body
      parsed_response_body = JSON.parse(raw_response_body)
      klass.new(parsed_response_body,
                raw_response.body,
                status,
                check_success?(status))
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
      raw_response = connection.connect.send(method, "/2.0/accounts/#{id}")
      status = raw_response.status.to_s
      raw_response_body = raw_response.body
      parsed_response_body = JSON.parse(raw_response_body)
      Accounts.new(parsed_response_body,
                   raw_response_body,
                   status,
                   check_success?(status),
                   connection)
    else
      raw_response = connection.connect.send(method, "/2.0/accounts")
      status = raw_response.status.to_s
      raw_response_body = connection.connect.send(method, "/2.0/accounts").body
      parsed_response_body = JSON.parse(raw_response_body)
      Accounts.new(parsed_response_body,
                   raw_response_body,
                   status,
                   check_success?(status))
    end
  end

  def check_success?(status)
    status == "200"
  end
end
