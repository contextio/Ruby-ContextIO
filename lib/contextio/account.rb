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
    attr_reader :id, :success, :connection, :status, :api_call_made, *ACCOUNT_READERS
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

    def get_connect_tokens
      collection_return(url: "#{call_url}/connect_tokens",
                        parent: self,
                        klass: ConnectToken)
    end

    def get_contacts(**kwargs)
      contact_collection_return(url: "#{call_url}/contacts",
                                valid_params: ValidGetParams::CONTACTS,
                                given_params: kwargs)
    end

    def get_email_addresses
      collection_return(url: "#{call_url}/email_addresses",
                        parent: self,
                        klass: EmailAddress)
    end

    def get_files(**kwargs)
      collection_return(url: "#{call_url}/files",
                        parent: self,
                        klass: Files,
                        valid_params: ValidGetParams::FILES,
                        given_params: kwargs)
    end

    def get_messages(**kwargs)
      collection_return(url: "#{call_url}/messages",
                        parent: self,
                        klass: Message,
                        valid_params: ValidGetParams::MESSAGES,
                        given_params: kwargs)
    end

    def get_sources(**kwargs)
      collection_return(url: "#{call_url}/sources",
                        parent: self,
                        klass: Sources,
                        valid_params: ValidGetParams::SOURCES,
                        given_params: kwargs)
    end

    def get_sync
      Sync.new(parent: self).get
    end

    def get_threads(**kwargs)
      call_api_return_new_object(klass: Threads,
                                 identifier: "no identifier",
                                 url: "#{call_url}/threads",
                                 valid_params: ValidGetParams::THREADS,
                                 given_params: kwargs)
    end

    def get_webhooks
      collection_return(url: "#{call_url}/webhooks",
                        parent: self,
                        klass: Webhook)
    end
  end
end
