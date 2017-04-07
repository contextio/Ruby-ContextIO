require "contextio/utilities/collection_helper"
require "contextio/utilities/call_helpers"
module ContextIO
  class Account
    include ContextIO::CallHelpers
    ACCOUNT_READERS = %I(username created suspended email_addresses first_name last_name
                       password_expired sources resource_url)
    private
    attr_reader :parent

    public
    attr_accessor :api_call_made
    attr_reader :id, :success, :connection, :status, *ACCOUNT_READERS
    def initialize(parent:,
                   identifier: nil,
                   response: nil,
                   status: nil,
                   success: nil,
                   api_call_made: nil)
      @parent = parent
      @connection = parent.connection
      @id = identifier
      @status = status
      @success = success
      @api_call_made = api_call_made
      if response
        parse_response(response)
      end
    end

    def call_url
      build_url("accounts", id)
    end

    def post(**kwargs)
      call_api_return_updated_object(klass: Account,
                                     method: :post,
                                     identifier: id,
                                     url: call_url,
                                     valid_params: ValidPostParams::ACCOUNT,
                                     given_params: kwargs)
    end

    def get_connect_tokens
      collection_return(url: "#{call_url}/connect_tokens",
                        klass: ConnectToken)
    end

    def post_connect_token(callback_url:, **kwargs)
      given_params = kwargs.merge(callback_url: callback_url)
      token = call_api_return_new_object(klass: ConnectToken,
                                         url: "#{call_url}/connect_tokens",
                                         method: :post,
                                         valid_params: ValidPostParams::CONNECT_TOKEN,
                                         given_params: given_params)
      return_post_api_call_made(token)
    end

    def get_contacts(**kwargs)
      contact_collection_return(url: "#{call_url}/contacts",
                                valid_params: ValidGetParams::CONTACTS,
                                given_params: kwargs)
    end

    def get_email_addresses
      collection_return(url: "#{call_url}/email_addresses",
                        klass: EmailAddress)
    end

    def post_email_address(email_address:)
      given_params = { email_address: email_address }
      email = call_api_return_new_object(klass: EmailAddress,
                                         url: "#{call_url}/email_addresses",
                                         method: :post,
                                         valid_params: [:email_address],
                                         given_params: given_params)
      return_post_api_call_made(email)
    end

    def get_files(**kwargs)
      collection_return(url: "#{call_url}/files",
                        klass: Files,
                        valid_params: ValidGetParams::FILES,
                        given_params: kwargs)
    end

    def get_messages(**kwargs)
      collection_return(url: "#{call_url}/messages",
                        klass: Message,
                        valid_params: ValidGetParams::MESSAGES,
                        given_params: kwargs)
    end

    def get_sources(**kwargs)
      collection_return(url: "#{call_url}/sources",
                        klass: Sources,
                        valid_params: ValidGetParams::SOURCES,
                        given_params: kwargs)
    end

    def post_source(email:, server:, username:, use_ssl:, port:, type: "IMAP", **kwargs)
      given_params = kwargs.merge(email: email,
                                  server: server,
                                  username: username,
                                  use_ssl: use_ssl,
                                  port: port,
                                  type: type)
      token = call_api_return_new_object(klass: Sources,
                                         url: "#{call_url}/sources",
                                         method: :post,
                                         valid_params: ValidPostParams::SOURCES,
                                         given_params: given_params)
      return_post_api_call_made(token)
    end

    def get_sync
      Sync.new(parent: self).get
    end

    def get_threads(**kwargs)
      call_api_return_new_object(klass: Threads,
                                 url: "#{call_url}/threads",
                                 valid_params: ValidGetParams::THREADS,
                                 given_params: kwargs)
    end

    def get_webhooks
      collection_return(url: "#{call_url}/webhooks",
                        klass: Webhook)
    end

    def post_webhook(callback_url:, failure_notif_url:, **kwargs)
      given_params = kwargs.merge(callback_url: callback_url,
                                  failure_notif_url: failure_notif_url)
      token = call_api_return_new_object(klass: Webhook,
                                         url: "#{call_url}/webhooks",
                                         method: :post,
                                         valid_params: ValidPostParams::WEBHOOKS,
                                         given_params: given_params)
      return_post_api_call_made(token)
    end
  end
end
