module ContextIO
  class Contact
    include ContextIO::CallHelpers
    CONTACT_READERS =  %I(emails name thumbnail last_received last_sent count sent_count
                       received_count sent_from_account_count query email resource_url)

    attr_reader :response, :status, :parent, :connection, :success, :email, *CONTACT_READERS
    def initialize(parent:,
                   identifier: nil,
                   response: nil,
                   status: nil,
                   success: nil)
      @parent = parent
      @connection = parent.connection
      @email = identifier
      @status = status
      @success =  success
      if response
        parse_response(response)
      end
    end

    def encoded_email
      ERB::Util.url_encode(email)
    end

    def call_url
      build_url("contacts", encoded_email)
    end

    def valid_get_files_params
      ValidParams::GET_CONTACT_FILES_PARAMS
    end

    def valid_get_messages_params
      ValidParams::GET_CONTACT_MESSAGES_PARAMS
    end

    def valid_get_threads_params
      ValidParams::GET_CONTACT_THREADS_PARAMS
    end

    def get_files(**kwargs)
      valid_params = get_params(kwargs, valid_get_files_params)
      collection_return("#{call_url}/files", self, Files, valid_params)
    end

    def get_messages(**kwargs)
      valid_params = get_params(kwargs, valid_get_messages_params)
      collection_return("#{call_url}/messages", self, Message, valid_params)
    end

    def get_threads(**kwargs)
      valid_params = get_params(kwargs, valid_get_threads_params)
      request = Request.new(connection, :get, "#{call_url}/threads", valid_params)
      Threads.new(parent: self,
                 response: request.response,
                 status: request.status,
                 success: request.success)
    end
  end
end
