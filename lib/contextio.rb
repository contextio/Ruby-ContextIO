Dir["./lib/contextio/*.rb"].each {|file| require file }
Dir["./lib/contextio/**/*.rb"].each {|file| require file }

require "json"

module ContextIO
  class ContextIO
    include CollectionHelper
    attr_reader :connection, :call_url, :version
    def initialize(key:, secret:, version:)
      @connection = Connection.new(key, secret)
      @call_url = "/#{version}"
      @version = version
    end

    def get_accounts
      request = Request.new(connection, :get, "#{call_url}/accounts")
      collection_return(request, self, Account)
    end

    def get_connect_tokens
      request = Request.new(connection, :get, "#{call_url}/connect_tokens")
      collection_return(request, self, ConnectToken)
    end

    def discovery(email:)
      Discovery.new(parent: self, email: email).get
    end

    def get_oauth_providers
      request = Request.new(connection, :get, "#{call_url}/oauth_providers")
      collection_return(request, self, OauthProvider)
    end

    def get_webhooks
      request = Request.new(connection, :get, "#{call_url}/webhooks")
      collection_return(request, self, Webhook)
    end
  end
end
