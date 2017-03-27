module ContextIO
  class Message
    include ContextIO::CallHelpers
    MESSAGE_READERS = %I(date date_indexed date_received addresses person_info email_message_id
                       message_id gmail_message_id gmail_thread_id files subject
                       folders sources content type charset body_section answered
                       deleted draft flagged seen in_reply_to references resource_url)
    private
    attr_reader :parent

    public
    attr_reader :status, :success, :connection, :message_id, :response, :api_call_made, *MESSAGE_READERS
    def initialize(parent:,
                   identifier: nil,
                   response: nil,
                   status: nil,
                   success: nil,
                   api_call_made: nil)
      @parent = parent
      @connection = parent.connection
      @message_id = identifier
      @status = status
      @success = success
      @api_call_made = api_call_made
      if response
        parse_response(response)
      end
    end

    def encoded_message_id
      ERB::Util.url_encode(message_id)
    end

    def call_url
      build_url("messages", encoded_message_id)
    end

    def body
      call_api_return_new_object(Message, message_id, "#{call_url}/body")
    end

    def flags
      call_api_return_new_object(Message, message_id, "#{call_url}/flags")
    end

    def folders
      call_api_return_new_object(Message, message_id, "#{call_url}/folders")
    end

    def headers
      call_api_return_new_object(Message, message_id, "#{call_url}/headers")
    end

    def source
      call_api_return_new_object(Message, message_id, "#{call_url}/source")
    end

    def threads
      call_api_return_new_object(Message, message_id, "#{call_url}/thread")
    end
  end
end
