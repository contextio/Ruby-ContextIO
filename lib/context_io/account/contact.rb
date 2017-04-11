module ContextIO
  class Contact
    include ContextIO::CallHelpers
    CONTACT_READERS =  %I(emails name thumbnail last_received last_sent count sent_count
                       received_count sent_from_account_count query email resource_url)
    private
    attr_reader :parent

    public
    attr_accessor :api_call_made
    attr_reader :response, :status, :parent, :connection, :success, :email,
                 *CONTACT_READERS
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
      collection_return(url: "#{call_url}/files",
                        klass: Files,
                        valid_params: ValidGetParams::CONTACT_FILES,
                        given_params: kwargs)
    end

    def get_messages(**kwargs)
      collection_return(url: "#{call_url}/messages",
                        klass: Message,
                        valid_params: ValidGetParams::CONTACT_MESSAGES,
                        given_params: kwargs)
    end

    def get_threads(**kwargs)
      call_api_return_new_object(klass: Threads,
                                 url: "#{call_url}/threads",
                                 valid_params: ValidGetParams::THREADS,
                                 given_params: kwargs)
    end
  end
end
