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
      valid_params = %I(search activity_before activity_after sort_by sort_order limit offset)
      params = get_params(kwargs, valid_params)
      contact_collection_return("#{call_url}/contacts", params)
    end

    def get_email_addresses
      collection_return("#{call_url}/email_addresses", self, EmailAddress)
    end

    def get_files(**kwargs)
      valid_params = %I(file_name file_size_min file_size_max email to from cc bcc
                        date_before date_after indexed_before indexed_after source
                        sort_order limit offset)
      params = get_params(kwargs, valid_params)
      collection_return("#{call_url}/files", self, Files, params)
    end

    def get_messages
      valid_params = %I(subject email to from cc bcc folder source file_name file_size_min
                        file_size_max date_before date_after indexed_before indexed_after
                        include_thread_size include_body include_headers include_flags
                        body_type include_source sort_order limit offset)
      params = get_params(kwargs, valid_params)
      collection_return("#{call_url}/messages", self, Message, params)
    end

    def get_sources
      valid_params = %I(status status_ok)
      params = get_params(kwargs, valid_params)
      collection_return("#{call_url}/sources", self, Sources, params)
    end

    def get_sync
      Sync.new(parent: self).get
    end

    def get_threads
      valid_params = %I(subject email to from cc bcc folder indexed_before indexed_after
                        activity_before activity_after started_before started_after
                        limit offset)
      params = get_params(kwargs, valid_params)
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
