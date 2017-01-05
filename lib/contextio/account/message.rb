module ContextIO
  class Message < BaseClass
    MESSAGE_ATTRS = %I(date date_indexed addresses person_info email_message_id
                       message_id gmail_message_id gmail_thread_id files subject
                       folders sources content type charset body_section)
    private
    attr_reader :parent

    public
    include CollectionHelper
    attr_reader :status, :success, :connection, :message_id, *MESSAGE_ATTRS
    def initialize(parent:,
                   identifier: nil,
                   response: nil,
                   status: nil,
                   success: nil)
      @parent = parent
      @connection = parent.connection
      @message_id = identifier
      @status = status
      @success = success
      if response.class == Array
        binding.pry
        parse_body_response(response)
      else
        parse_response(response)
      end

      def parse_array_response(response)
       response.each do |index|
         index.each { |k,v| instance_variable_set("@#{k}", v) }
       end
      end

      def call_url
        build_url("messages", message_id)
      end

      def body
        url = "#{call_url}/body"
        resp = Request.new(connection, :get, url)
        Message.new(parent: parent,
                    identifier: message_id,
                    response: resp.response,
                    status: resp.status,
                    success: resp.success)
      end

      def flags
        call_api("#{call_url}/flags")
      end

      def folders
        call_api("#{call_url}/folders")
      end

      def headers
        call_api("#{call_url}/headers")
      end

      def source
        call_api("#{call_url}/source")
      end

      def threads
        call_api("#{call_url}/threads")
      end
    end
  end
end
