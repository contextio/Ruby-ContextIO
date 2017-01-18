module ContextIO
  class Sources
  include ContextIO::CallHelpers
  SOURCE_READERS = %I(username status type label use_ssl resource_url server
                      port mailserviceAccountId callbackUrl delimiter
                      authentication_type sync_flags type)

    private
    attr_reader :parent

    public
    attr_reader :status, :success, :connection, :message_id, :response, *SOURCE_READERS
    def initialize(parent:,
                   identifier: nil,
                   response: nil,
                   status: nil,
                   success: nil)
      @status = status
      @success = success
      @parent = parent
      @connection = parent.connection
      @label = identifier
      if response
        parse_response(response)
      end
    end

    def call_url
      build_url("sources", label)
    end

    def folders(folder: nil)
      if folder
        call_api_return_new_class(Folder, folder)
      else
        collection_return("#{call_url}/folders", self, Folder)
      end
    end

    def sync
      Sync.new(parent: self).get
    end

    def connect_tokens(token: nil)
      if token
        call_api_return_new_class(ConnectToken, token)
      else
        collection_return("#{call_url}/connect_tokens", self, ConnectToken)
      end
    end
  end
end
