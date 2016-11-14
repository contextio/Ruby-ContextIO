require "json"

class Accounts
  attr_reader :response, :raw_response
  def initialize(response, raw_response)
    @response = response
    @raw_response = raw_response
  end

  def self.fetch(connection, id = nil, method = :get)
    if id != nil
      raw_response = connection.send(method, "/2.0/accounts/#{id}").body
      response = JSON.parse(raw_response)
      Accounts.new(response, raw_response)
    else
      raw_response = connection.send(method, "/2.0/accounts").body
      response = JSON.parse(raw_response)
      Accounts.new(response, raw_response)
    end
  end
end
