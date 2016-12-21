class Message
  MESSAGE_ATTRS = %I(date date_indexed addresses person_info email_message_id
                     message_id gmail_message_id gmail_thread_id files subject
                     folders sources)
  private
  attr_reader :context_io

  public
  include RequestHelper
  attr_reader :status, :success, :account_id, :message_id, *MESSAGE_ATTRS
  def initialize(context_io:,
                 account_id:,
                 identifier: nil,
                 response: nil,
                 status: nil,
                 success: nil)
    @context_io = context_io
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
