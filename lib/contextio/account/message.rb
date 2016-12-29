module ContextIO
  class Message < BaseClass
    MESSAGE_ATTRS = %I(date date_indexed addresses person_info email_message_id
                       message_id gmail_message_id gmail_thread_id files subject
                       folders sources)
    private
    attr_reader :parent

    public
    include RequestHelper
    attr_reader :status, :success, :account_id, :message_id, *MESSAGE_ATTRS
    def initialize(parent:,
                   account_id: nil,
                   identifier: nil,
                   response: nil,
                   status: nil,
                   success: nil)
      @parent = parent
      @account_id = account_id
      @message_id = identifier
      @response = response
      @status = status
      @success = success
      if response
        response.each { |k,v| instance_variable_set("@#{k}", v) }
      end
    end
  end
end
