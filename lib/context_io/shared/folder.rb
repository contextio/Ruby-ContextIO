module ContextIO
  class Folder
    include ContextIO::CallHelpers
    FOLDER_READERS = %I(symbolic_name attributes delim nb_messages xlist_name
                        nb_unseen_messages resource_url name)

    private
    attr_reader :parent

    public
    attr_accessor :api_call_made
    attr_reader :status, :success, :connection, :response, *FOLDER_READERS
    def initialize(parent:,
                   identifier: nil,
                   response: nil,
                   status: nil,
                   success: nil,
                   api_call_made: nil)
      @status = status
      @success = success
      @parent = parent
      @connection = parent.connection
      @name = identifier
      @api_call_made = api_call_made
      if response
        parse_response(response)
      end
    end

    def encoded_name
      ERB::Util.url_encode(name)
    end

    def call_url
      build_url("folders", encoded_name)
    end

    def source_parent?
      parent.class == Sources
    end

    def get(**kwargs)
      if source_parent?
        get_request(given_params: kwargs, valid_params: ValidGetParams::SOURCE_FOLDER)
      else
        get_request(given_params: kwargs)
      end
    end

    def get_messages(**kwargs)
      collection_return(url: "#{call_url}/messages",
                        klass: Message,
                        valid_params: ValidGetParams::SOURCE_FOLDER_MESSAGES,
                        given_params: kwargs)
    end
  end
end
