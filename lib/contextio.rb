Dir["./lib/contextio/*.rb"].each {|file| require file }
Dir["./lib/contextio/accounts/*.rb"].each {|file| require file }

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
