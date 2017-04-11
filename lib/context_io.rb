require 'context_io/account'
require 'context_io/connection'
require 'context_io/oauth_provider'

require 'context_io/account/contact'
require 'context_io/account/email_address'
require 'context_io/account/files'
require 'context_io/account/sources'
require 'context_io/account/sync'
require 'context_io/account/threads'

require 'context_io/shared/connect_token'
require 'context_io/shared/discovery'
require 'context_io/shared/folder'
require 'context_io/shared/message'
require 'context_io/shared/webhook'

require 'context_io/utilities/api_call_made'
require 'context_io/utilities/call_helpers'
require 'context_io/utilities/collection_helper'
require 'context_io/utilities/deleted_resource'
require 'context_io/utilities/request'
require 'context_io/utilities/valid_parameters/get_params'
require 'context_io/utilities/valid_parameters/post_params'

require "erb"

module ContextIO
  class ContextIO
    include CollectionHelper
    include CallHelpers
    attr_reader :connection, :call_url
    def initialize(key:, secret:)
      @connection = Connection.new(key, secret)
      @call_url = "/2.0"
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
      return_post_api_call_made(provider)
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
