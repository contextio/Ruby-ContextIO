module ContextIO
  class Contact
    CONTACT_READERS =  %I(emails name thumbnail last_received last_sent count sent_count
                       received_count sent_from_account_count query email resource_url)

    private
    attr_reader :connection

    public
    include RequestHelper
    attr_reader :response, :status, :parent, :success, :email, *CONTACT_READERS
    def initialize(parent:,
                   identifier: nil,
                   response: nil,
                   status: nil,
                   success: nil)
      @parent = parent
      @connection = parent.connection
      @email = identifier
      @status = status
      @success =  success
      if response
        parse_response(response)
      end
    end

    def call_url
      build_url("contacts", email)
    end

    def get
      request = Request.new(parent.connection, :get, call_url)
      parse_response(request.response)
      @status = request.status
      @success = check_success(status)
      self
    end

    def get_files
      request = Request.new(parent.connection, :get, "#{call_url}/files")
      collection_return(request, parent, Files)
    end

    def get_threads
      request = Request.new(parent.connection, :get, "#{call_url}/threads")
      Threads.new(parent: parent,
                 response: request.response,
                 status: request.status,
                 success: request.success)
    end

    def get_messages
      request = Request.new(parent.connection, :get, "#{call_url}/messages")
      collection_return(request, parent, Message)
    end
  end
end
