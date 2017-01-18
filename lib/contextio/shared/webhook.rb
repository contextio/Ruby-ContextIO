module ContextIO
  class Webhook
    include ContextIO::CallHelpers
    WEBHOOK_READERS = %I(callback_url failure_notif_url active webhook_id resource_url)

    private
    attr_reader :parent

    public
    attr_reader :webhook_id, :success, :connection, :status, *WEBHOOK_READERS
    def initialize(parent:,
                   identifier: nil,
                   response: nil,
                   status: nil,
                   success: nil)
      @parent = parent
      @connection = parent.connection
      @webhook_id = identifier
      @status = status
      @success = success
      if response
        parse_response(response)
      end
    end

    def call_url
      build_url("webhooks", webhook_id)
    end
  end
end