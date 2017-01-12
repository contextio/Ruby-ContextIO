module ContextIO
  class Sources < BaseClass
  SOURCE_READERS = %I(username status type label use_ssl resource_url server
                      port mailserviceAccountId callbackUrl delimiter
                      authentication_type sync_flags type)

    private
    attr_reader :parent

    public
    include CollectionHelper
    attr_reader :status, :success, :connection, :message_id, *SOURCE_READERS
    def initialize(parent:,
                   identifier: nil,
                   response: nil,
                   status: nil,
                   success: nil)
      @status = status
      @success =  success
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
  end
end
