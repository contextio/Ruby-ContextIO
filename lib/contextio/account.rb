require "contextio/utilities/collection_helper"
module ContextIO
  class Account < BaseClass
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
      request = Request.new(connection, :get, "#{call_url}/connect_tokens")
      collection_return(request, self, ConnectToken)
    end

    def get_contacts
      request = Request.new(connection, :get, "#{call_url}/contacts")
      contact_collection_return(request, self)
    end

    def get_email_addresses
      request = Request.new(connection, :get, "#{call_url}/email_addresses")
      collection_return(request, self, EmailAddress)
    end

    def get_files
      request = Request.new(connection, :get, "#{call_url}/files")
      collection_return(request, self, Files)
    end

    def get_messages
      request = Request.new(connection, :get, "#{call_url}/messages")
      collection_return(request, self, Message)
    end

    def get_sources
      request = Request.new(connection, :get, "#{call_url}/sources")
      collection_return(request, self, Sources)
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
      request = Request.new(connection, :get, "#{call_url}/webhooks")
      collection_return(request, self, Webhooks)
    end
  end
end
