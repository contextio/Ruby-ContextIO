module ContextIO
  class Files < BaseClass
    FILE_READERS = %I(size type subject date date_indexed addresses person_info
                   file_name file_name_structure body_section supports_preview
                   is_embedded content_disposition content_id message_id
                   email_message_id gmail_message_id gmail_thread_id email_addresses
                   created first_name id last_name resource_url sources is_tnef_part)

    private
    attr_reader :connection

    public
    include CollectionHelper
    attr_reader :parent, :response, :status, :success, :file_id, *FILE_READERS
    def initialize(parent:,
                   identifier: nil,
                   response: nil,
                   status: nil,
                   success: nil)
      @parent = parent
      @connection = parent.connection
      @file_id = identifier
      @status = status
      @success = success
      if response
        parse_response(response)
      end
    end

    def call_url
      build_url("files", file_id)
    end

    def content
      url = "#{call_url}/content"
      resp = Request.new(connection, :get, url)
      Files.new(parent: parent,
                identifier: file_id,
                response: resp.response,
                status: resp.status,
                success: resp.status)
    end
  end
end
