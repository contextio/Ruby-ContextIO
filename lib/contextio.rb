require "contextio/version"
require "contextio/connection"

module ContextIO
  class ContextIO
    attr_reader :key, :secret
    def initialize(key, secret)
      @key = key
      @secret = secret
    end

    def accounts
      response = Connection.connect(key, secret).send(:get, "/2.0/accounts").body
    end
  end
end
