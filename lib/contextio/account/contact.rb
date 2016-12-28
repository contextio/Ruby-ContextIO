module ContextIO
  class Contact
    CONTACT_ATTRS =  %I(emails name thumbnail last_received last_sent count sent_count
                       received_count sent_from_account_count)

    private
    attr_reader :parent

    public
    include RequestHelper
    attr_reader :response, :status, :success, :account_id, :email, *CONTACT_ATTRS
    def initialize(parent:,
                   account_id:,
                   identifier: nil,
                   response: nil,
                   status: nil,
                   success: nil)
      @parent = parent
      @account_id = account_id
      @email = identifier
      @status = status
      @success =  success
      if response
        response.each { |k,v| instance_variable_set("@#{k}", v) }
      end
    end

    def get
      request = Request.new(parent.connection, :get, "/2.0/accounts/#{account_id}/contacts/#{email}")
      Contact.new(parent: parent,
                  account_id: account_id,
                  identifier: email,
                  response: request.response,
                  status: request.status,
                  success: request.success)
    end

    def get_files
      request = Request.new(parent.connection, :get, "/2.0/accounts/#{account_id}/contacts/#{email}/files")
      collection_return(request, parent, Files, account_id)
    end

    def get_threads
      request = Request.new(parent.connection, :get, "2.0/accounts/#{account_id}/contacts/#{email}/threads")
      Threads.new(parent: parent,
                 account_id: account_id,
                 response: request.response,
                 status: request.status,
                 success: request.success)
    end

    def get_messages
      request = Request.new(parent.connection, :get, "/2.0/accounts/#{account_id}/contacts/#{email}/messages")
      collection_return(request, parent, Message, account_id)
    end
  end
end
