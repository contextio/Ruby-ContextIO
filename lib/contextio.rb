require "contextio/version"
require "contextio/connection"
require "contextio/accounts"

require "json"

module ContextIO
  class ContextIO
    attr_reader :connection
    def initialize(key, secret)
      @connection = Connection.new(key, secret)
    end

    def accounts(id = nil)
      Accounts.fetch(connection, id)
    end
  end
end
