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

    def get_contacts
      contact_collection_return("#{call_url}/contacts")
    end

    def get_email_addresses
      collection_return("#{call_url}/email_addresses", self, EmailAddress)
    end

    def get_files
      collection_return("#{call_url}/files", self, Files)
    end

    def get_messages
      collection_return("#{call_url}/messages", self, Message)
    end

    def get_sources
      collection_return("#{call_url}/sources", self, Sources)
    end

    def get_sync
      Sync.new(parent: self).get
    end

    def get_threads
      request = Request.new(connection, :get, "#{call_url}/threads")
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
