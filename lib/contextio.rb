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
      collection_return(url: "#{call_url}/accounts",
                        parent: self,
                        klass: Account,
                        valid_params: ValidGetParams::ACCOUNTS,
                        given_params: kwargs)
    end

    def get_connect_tokens
      collection_return(url: "#{call_url}/connect_tokens",
                        parent: self,
                        klass: ConnectToken)
    end

    def discovery(email:)
      Discovery.new(parent: self, email: email).get
    end

    def get_oauth_providers
      collection_return(url: "#{call_url}/oauth_providers",
                        parent: self,
                        klass: OauthProvider)
    end

    def get_webhooks
      collection_return(url: "#{call_url}/webhooks",
                        parent: self,
                        klass: Webhook)
    end
  end
end
