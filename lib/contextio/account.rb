require "contextio/utilities/collection_helper"
module ContextIO
  class Account < BaseClass
    ACCOUNT_READERS = %I(username created suspended email_addresses first_name last_name
                       password_expired sources resource_url)
    private
    attr_reader :parent

    public
    include CollectionHelper
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

    def get
      call_api
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
  end
end
