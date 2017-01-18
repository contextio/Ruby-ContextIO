module ContextIO
  class Threads
    include ContextIO::CallHelpers
    THREADS_READERS = %I(gmail_thread_id email_message_ids person_info messages)

    private
    attr_reader :parent

    public
    attr_reader :status, :success, :connection, :thread_id, *THREADS_READERS
    def initialize(parent:,
                   identifier: nil,
                   response: nil,
                   status: nil,
                   success: nil)
      @parent = parent
      @connection = parent.connection
      @thread_id = identifier
      @response = response
      @status = status
      @success =  success
    end

    def call_url
      build_url("threads", thread_id)
    end
  end
end
