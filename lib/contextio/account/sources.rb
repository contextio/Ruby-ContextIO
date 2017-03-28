module ContextIO
  class Sources
  include ContextIO::CallHelpers
  include ContextIO::CollectionHelper
  SOURCE_READERS = %I(username status type label use_ssl resource_url server
                      port mailserviceAccountId callbackUrl delimiter
                      authentication_type sync_flags type)

    private
    attr_reader :parent

    public
    attr_reader :status, :success, :connection, :message_id, :response, :api_call_made, *SOURCE_READERS
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
      @label = identifier
      @api_call_made = api_call_made
      if response
        parse_response(response)
      end
    end

    def call_url
      build_url("sources", label)
    end

    def get_folders(**kwargs)
      collection_return(url: "#{call_url}/folders",
                        parent: self,
                        klass: Folder,
                        valid_params: ValidGetParams::FOLDERS_SOURCES,
                        given_params: kwargs)
    end

    def folders(folder:, **kwargs)
      url = "#{call_url}/folders/#{folder}"
      call_api_return_new_object(klass: Folder,
                                 identifier: folder,
                                 url: url,
                                 valid_params: ValidGetParams::SOURCE_FOLDER,
                                 given_params: kwargs)
    end

    def sync
      Sync.new(parent: self).get
    end

    def get_connect_tokens
      collection_return(url: "#{call_url}/connect_tokens",
                        parent: self,
                        klass: ConnectToken)
    end

    def connect_tokens(token:)
      call_api_return_new_object(klass: ConnectToken,
                                 identifier: token,
                                 url: "#{call_url}/connect_tokens/#{token}")
    end
  end
end
