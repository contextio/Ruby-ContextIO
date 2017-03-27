module ContextIO
  class Contact
    include ContextIO::CallHelpers
    CONTACT_READERS =  %I(emails name thumbnail last_received last_sent count sent_count
                       received_count sent_from_account_count query email resource_url)

    attr_reader :response, :status, :parent, :connection, :success, :email,
                :api_call_made, *CONTACT_READERS
    def initialize(parent:,
                   identifier: nil,
                   response: nil,
                   status: nil,
                   success: nil,
                   api_call_made: nil)
      @parent = parent
      @connection = parent.connection
      @email = identifier
      @status = status
      @success = success
      @api_call_made = api_call_made
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

    def get_files(**kwargs)
      collection_return("#{call_url}/files", self, Files, ValidParams::GET_CONTACT_FILES, kwargs)
    end

    def get_messages(**kwargs)
      collection_return("#{call_url}/messages", self, Message, ValidParams::GET_CONTACT_MESSAGES, kwargs)
    end

    def get_threads(**kwargs)
      allowed_params, rejected_params = get_params(kwargs, ValidParams::GET_CONTACT_THREADS)
      request = Request.new(connection, :get, "#{call_url}/threads", allowed_params)
      raise StandardError, build_error_message(request.status, request.response) if request.success == false
      api_call_made = APICallMade::CALL_MADE_STRUCT.new(request.url,
                                                        allowed_params,
                                                        rejected_params)
      Threads.new(parent: self,
                 response: request.response,
                 status: request.status,
                 success: request.success,
                 api_call_made: api_call_made)
    end
  end
end
