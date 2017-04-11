module ContextIO
  class Webhook
    include ContextIO::CallHelpers
    WEBHOOK_READERS = %I(callback_url failure_notif_url active webhook_id resource_url)

    private
    attr_reader :parent

    public
    attr_accessor :api_call_made
    attr_reader :webhook_id, :success, :connection, :status, *WEBHOOK_READERS
    def initialize(parent:,
                   identifier: nil,
                   response: nil,
                   status: nil,
                   success: nil,
                   api_call_made: nil)
      @parent = parent
      @connection = parent.connection
      @webhook_id = identifier
      @status = status
      @success = success
      @api_call_made = api_call_made
      if response
        parse_response(response)
      end
    end

    def call_url
      build_url("webhooks", webhook_id)
    end

    def post(**kwargs)
      webhook = call_api_return_updated_object(klass: Webhook,
                                               url: call_url,
                                               identifier: webhook_id,
                                               method: :post,
                                               valid_params: ValidPostParams::WEBHOOK,
                                               given_params: kwargs)
      return_post_api_call_made(webhook)
    end
  end
end
