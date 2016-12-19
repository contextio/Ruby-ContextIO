Dir["./lib/contextio/*.rb"].each {|file| require file }
Dir["./lib/contextio/account/*.rb"].each {|file| require file }
Dir["./lib/contextio/utilities/*.rb"].each {|file| require file }

require "json"

module ContextIO
  class ContextIO
    include RequestHelper
    attr_reader :connection
    def initialize(key:, secret:)
      @connection = Connection.new(key, secret)
    end

    def collection_return(request, context_io, klass, identifier)
      request.response.map do |resp|
        klass.new(context_io: context_io,
                  identifier: resp[identifier],
                  response: resp,
                  status: request.status,
                  success: request.success)
      end
    end

    def get_accounts
      request = Request.new(connection, :get, "/2.0/accounts")
      collection_return(request, self, Account, "id")
    end

    def get_oauth_providers
      request = Request.new(connection, :get, "/2.0/oauth_providers")
      collection_return(request, connection, OauthProvider, "token")
    end
  end
end
