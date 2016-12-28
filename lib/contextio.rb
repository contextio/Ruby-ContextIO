Dir["./lib/contextio/*.rb"].each {|file| require file }
Dir["./lib/contextio/account/*.rb"].each {|file| require file }
Dir["./lib/contextio/utilities/*.rb"].each {|file| require file }

require "json"

module ContextIO
  class ContextIO
    include RequestHelper
    attr_reader :connection, :call_url, :version
    def initialize(key:, secret:, version:)
      @connection = Connection.new(key, secret)
      @call_url = "/#{version}"
      @version = version
    end

    def collection_return(request, context_io, klass)
      request.response.map do |resp|
        klass.new(context_io: context_io,
                  response: resp,
                  status: request.status,
                  success: request.success)
      end
    end

    def get_accounts
      request = Request.new(connection, :get, "/2.0/accounts")
      collection_return(request, self, Account)
    end

    def get_oauth_providers
      request = Request.new(connection, :get, "/2.0/oauth_providers")
      collection_return(request, connection, OauthProvider)
    end
  end
end
