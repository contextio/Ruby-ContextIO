module ContextIO
  class Message < BaseClass
    MESSAGE_ATTRS = %I(date date_indexed addresses person_info email_message_id
                       message_id gmail_message_id gmail_thread_id files subject
                       folders sources)
    private
    attr_reader :parent

    public
    include CollectionHelper
    attr_reader :status, :success, :account_id, :message_id, *MESSAGE_ATTRS
    def initialize(parent:,
                   identifier: nil,
                   response: nil,
                   status: nil,
                   success: nil)
      @parent = parent
      @message_id = identifier
      @response = response
      @status = status
      @success = success
      if response
        parse_response(response)
      end

      def call_url
        build_url("messages", message_id)
      end
    end
  end
end
