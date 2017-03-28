module ContextIO
  class Folder
    include ContextIO::CallHelpers
    FOLDER_READERS = %I(symbolic_name attributes delim nb_messages xlist_name
                        nb_unseen_messages resource_url name)

    private
    attr_reader :parent

    public
    attr_reader :status, :success, :connection, :response, :api_call_made, *FOLDER_READERS
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

    def source_url?
      parent.call_url.include?("/source/")
    end

    def get(**kwargs)
      if source_url?
        call_api(kwargs: kwargs, valid_params: ValidGetParams::SOURCE_FOLDER)
      else
        call_api(kwargs: kwargs)
      end
    end

    def messages(**kwargs)
      collection_return("#{call_url}/messages", self, Message, ValidGetParams::SOURCE_FOLDER_MESSAGES, kwargs)
    end
  end
end
