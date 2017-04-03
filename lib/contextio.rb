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
      return_post_api_call_made(account)
    end

    def get_connect_tokens
      collection_return(url: "#{call_url}/connect_tokens",
                        klass: ConnectToken)
    end

    def post_connect_token(callback_url: , **kwargs)
      given_params = kwargs.merge(callback_url: callback_url)
      token = call_api_return_new_object(klass: ConnectToken,
                                         url: "#{call_url}/connect_tokens",
                                         method: :post,
                                         valid_params: ValidPostParams::CONNECT_TOKEN,
                                         given_params: given_params)
      return_post_api_call_made(token)
    end

    def discovery(email:)
      Discovery.new(parent: self, email: email).get
    end

    def get_oauth_providers
      collection_return(url: "#{call_url}/oauth_providers",
                        klass: OauthProvider)
    end

    def post_oauth_provider(type:, provider_consumer_key:, provider_consumer_secret:)
      given_params = [type, provider_consumer_key, provider_consumer_secret]
      provider = call_api_return_new_object(klass: OauthProvider,
                                            url: "#{call_url}/oauth_provider",
                                            method: :post,
                                            valid_params: ValidPostParams::OAUTH_PROVIDER,
                                            given_params: given_params)
      return_post_api_call_made(token)
    end

    def get_webhooks
      collection_return(url: "#{call_url}/webhooks",
                        klass: Webhook)
    end

    def post_webhook(callback_url:, **kwargs)
      given_params = kwargs.merge(callback_url: callback_url)
      token = call_api_return_new_object(klass: Webhook,
                                         url: "#{call_url}/webhooks",
                                         method: :post,
                                         valid_params: ValidPostParams::WEBHOOK,
                                         given_params: given_params)
      return_post_api_call_made(token)
    end
  end
end
