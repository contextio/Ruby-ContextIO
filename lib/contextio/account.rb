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
      collection_return("#{call_url}/connect_tokens", self, ConnectToken)
    end

    def get_contacts(**kwargs)
      allowed_params, rejected_params = get_params(kwargs, ValidParams::GET_CONTACTS)
      contact_collection_return("#{call_url}/contacts", allowed_params, rejected_params)
    end

    def get_email_addresses
      collection_return("#{call_url}/email_addresses", self, EmailAddress)
    end

    def get_files(**kwargs)
      allowed_params, rejected_params = get_params(kwargs, ValidParams::GET_FILES)
      collection_return("#{call_url}/files", self, Files, allowed_params, rejected_params)
    end

    def get_messages(**kwargs)
      allowed_params, rejected_params = get_params(kwargs, ValidParams::GET_MESSAGES)
      collection_return("#{call_url}/messages", self, Message, allowed_params, rejected_params)
    end

    def get_sources(**kwargs)
      allowed_params, rejected_params = get_params(kwargs, ValidParams::GET_SOURCES)
      collection_return("#{call_url}/sources", self, Sources, allowed_params, rejected_params)
    end

    def get_sync
      Sync.new(parent: self).get
    end

    def get_threads(**kwargs)
      allowed_params, rejected_params = get_params(kwargs, ValidParams::GET_THREADS)
      request = Request.new(connection, :get, "#{call_url}/threads", allowed_params)
      api_call_made = APICallMade::CALL_MADE_STRUCT.new(request.url,
                                                        allowed_params,
                                                        rejected_params)
      Threads.new(parent: self,
                 response: request.response,
                 success: request.success,
                 status: request.status,
                 api_call_made: api_call_made)
    end

    def get_webhooks
      collection_return("#{call_url}/webhooks", self, Webhook)
    end
  end
end
