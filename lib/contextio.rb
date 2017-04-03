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
                        klass: Account,
                        valid_params: ValidGetParams::ACCOUNTS,
                        given_params: kwargs)
    end

    def post_account(type: "IMAP", **kwargs)
      given_params = kwargs.merge(type: type)
      account = call_api_return_new_object(klass: Account,
                                           url: "#{call_url}/accounts",
                                           method: :post,
                                           valid_params: ValidPostParams::ACCOUNTS,
                                           given_params: given_params)
      api_call_made = account.api_call_made
      return_post_api_call_made(account, api_call_made)
    end

    def get_connect_tokens
      collection_return(url: "#{call_url}/connect_tokens",
                        klass: ConnectToken)
    end

    def post_connect_tokens(callback_url: , **kwargs)
      given_params = kwargs.merge(callback_url: callback_url)
      token = call_api_return_new_object(klass: ConnectToken,
                                           url: "#{call_url}/connect_tokens",
                                           method: :post,
                                           valid_params: ValidPostParams::CONNECT_TOKENS,
                                           given_params: given_params)
      api_call_made = token.api_call_made
      return_post_api_call_made(token, api_call_made)
    end

    def discovery(email:)
      Discovery.new(parent: self, email: email).get
    end

    def get_oauth_providers
      collection_return(url: "#{call_url}/oauth_providers",
                        klass: OauthProvider)
    end

    def get_webhooks
      collection_return(url: "#{call_url}/webhooks",
                        klass: Webhook)
    end
  end
end
