require "contextio/connect_tokens"
require "contextio/contacts"

require "json"
ERROR_STRING = "This method can only be called on a single account".freeze

class Accounts
  attr_reader :response, :raw_response, :connection
  def initialize(response, raw_response, connection = nil)
    @response = response
    @raw_response = raw_response
    @connection = connection
  end

  def connect_tokens(id = nil, method = :get)
    account_id = recover_from_type_error
    if account_id == ERROR_STRING
      ConnectToken.new(ERROR_STRING, ERROR_STRING, false)
    else
      raw_response = connection.connect.send(method, "/2.0/accounts/#{account_id}/connect_tokens").body
      response = JSON.parse(raw_response)
      ConnectToken.new(response, raw_response)
    end
  end

  def contacts(id = nil, account_id = self.response["id"], method = :get)
    raw_response = connection.connect.send(method, "/2.0/accounts/#{account_id}/contacts").body
    response = JSON.parse(raw_response)
    Contacts.new(response, raw_response)
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
      Accounts.new(response, raw_response, connection)
    else
      raw_response = connection.connect.send(method, "/2.0/accounts").body
      response = JSON.parse(raw_response)
      Accounts.new(response, raw_response)
    end
  end
end
