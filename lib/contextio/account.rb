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
    attr_reader :id, :success, :connection, :status, *ACCOUNT_READERS
    def initialize(parent:,
                   identifier: nil,
                   response: nil,
                   status: nil,
                   success: nil)
      @parent = parent
      @connection = parent.connection
      @id = identifier
      @status = status
      @success = success
      if response
        parse_response(response)
      end
    end

    def call_url
      build_url("accounts", id)
    end

    def get_connect_tokens
      collection_return("#{call_url}/connect_tokens", self, ConnectToken)
    end

    def get_contacts(**kwargs)
      params = get_params(kwargs, ValidParams::GET_CONTACTS_PARAMS)
      contact_collection_return("#{call_url}/contacts", params)
    end

    def get_email_addresses
      collection_return("#{call_url}/email_addresses", self, EmailAddress)
    end

    def get_files(**kwargs)
      params = get_params(kwargs, ValidParams::GET_FILES_PARAMS)
      collection_return("#{call_url}/files", self, Files, params)
    end

    def get_messages(**kwargs)
      params = get_params(kwargs, ValidParams::GET_MESSAGES_PARAMS)
      collection_return("#{call_url}/messages", self, Message, params)
    end

    def get_sources(**kwargs)
      valid_params = %I(status status_ok)
      params = get_params(kwargs, valid_params)
      collection_return("#{call_url}/sources", self, Sources, params)
    end

    def get_sync
      Sync.new(parent: self).get
    end

    def get_threads(**kwargs)
      params = get_params(kwargs, ValidParams::GET_THREADS_PARAMS)
      request = Request.new(connection, :get, "#{call_url}/threads", params)
      Threads.new(parent: self,
                 response: request.response,
                 success: request.success,
                 status: request.status)
    end

    def get_webhooks
      collection_return("#{call_url}/webhooks", self, Webhook)
    end
  end
end
