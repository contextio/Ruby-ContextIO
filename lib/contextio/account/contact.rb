module ContextIO
  class Contact < BaseClass
    CONTACT_READERS =  %I(emails name thumbnail last_received last_sent count sent_count
                       received_count sent_from_account_count query email resource_url)
    
    attr_reader :response, :status, :parent, :connection, :success, :email, *CONTACT_READERS
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

    def get_files
      request = Request.new(connection, :get, "#{call_url}/files")
      collection_return(request, self, Files)
    end

    def get_threads
      request = Request.new(connection, :get, "#{call_url}/threads")
      Threads.new(parent: self,
                 response: request.response,
                 status: request.status,
                 success: request.success)
    end

    def get_messages
      request = Request.new(parent.connection, :get, "#{call_url}/messages")
      collection_return(request, self, Message)
    end
  end
end
