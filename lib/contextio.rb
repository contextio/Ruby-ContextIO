require "contextio/version"
require "contextio/connection"
require "contextio/accounts"

module ContextIO
  class ContextIO
    attr_reader :key, :secret
    def initialize(key, secret)
      @key = key
      @secret = secret
    end

    def connection(key, secret)
      Connection.connect(key, secret)
    end

    def accounts(id = nil)
      Accounts.fetch(connection(key, secret), id)
    end
  end
end
