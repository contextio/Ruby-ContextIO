Dir["./lib/contextio/*.rb"].each {|file| require file }
Dir["./lib/contextio/**/*.rb"].each {|file| require file }
require "erb"

module ContextIO
  class ContextIO
    include CollectionHelper
    include CallHelpers
    attr_reader :connection, :call_url, :version
    def initialize(key:, secret:, version:)
      @connection = Connection.new(key, secret)
      @call_url = "/#{version}"
      @version = version
    end

    def get_accounts(**kwargs)
      allowed_params, rejected_params = get_params(kwargs, ValidParams::GET_ACCOUNTSS)
      collection_return("#{call_url}/accounts", self, Account, allowed_params, rejected_params)
    end

    def get_connect_tokens
      collection_return("#{call_url}/connect_tokens", self, ConnectToken)
    end

    def discovery(email:)
      Discovery.new(parent: self, email: email).get
    end

    def get_oauth_providers
      collection_return("#{call_url}/oauth_providers", self, OauthProvider)
    end

    def get_webhooks
      collection_return("#{call_url}/webhooks", self, Webhook)
    end
  end
end
