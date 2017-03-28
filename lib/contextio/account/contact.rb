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
      collection_return("#{call_url}/files", self, Files, ValidGetParams::CONTACT_FILES, kwargs)
    end

    def get_messages(**kwargs)
      collection_return("#{call_url}/messages", self, Message, ValidGetParams::CONTACT_MESSAGES, kwargs)
    end

    def get_threads(**kwargs)
      call_api_return_new_object(klass: Threads,
                                 identifier: "no identifier",
                                 url: "#{call_url}/threads",
                                 valid_params: ValidGetParams::THREADS,
                                 given_params: kwargs)
    end
  end
end
