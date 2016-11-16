require "contextio/connect_tokens"
require "contextio/contacts"

require "json"
ERROR_STRING = "This method can only be called on a single account".freeze

class Accounts
  attr_reader :response, :raw_response, :connection
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
    if id != nil
      raw_response = connection.connect.send(method, "/2.0/accounts/#{id}").body
      response = JSON.parse(raw_response)
      success = Accounts.invalid_id?(response)
      Accounts.new(response, raw_response, success, connection)
    else
      raw_response = connection.connect.send(method, "/2.0/accounts").body
      response = JSON.parse(raw_response)
      Accounts.new(response, raw_response)
    end
  end

  def self.invalid_id?(response)
    return true if response["value"] == nil
    response["value"].split(" ").last != "invalid"
  end
end
