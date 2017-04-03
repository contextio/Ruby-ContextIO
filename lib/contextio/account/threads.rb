module ContextIO
  class Threads
    include ContextIO::CallHelpers
    THREADS_READERS = %I(gmail_thread_id email_message_ids person_info messages)

    private
    attr_reader :parent

    public
    attr_reader :api_call_made
    attr_reader :status, :success, :connection, :thread_id, *THREADS_READERS
    def initialize(parent:,
                   identifier: nil,
                   response: nil,
                   status: nil,
                   success: nil,
                   api_call_made: nil)
      @parent = parent
      @connection = parent.connection
      @thread_id = identifier
      @response = response
      @status = status
      @success = success
      @api_call_made = api_call_made
    end

    def call_url
      build_url("threads", thread_id)
    end

    def get(**kwargs)
      get_request(given_params: kwargs, valid_params: ValidGetParams::THREAD)
    end
  end
end
