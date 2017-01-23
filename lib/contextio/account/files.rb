module ContextIO
  class Files
    include ContextIO::CallHelpers
    FILE_READERS = %I(size type subject date date_indexed addresses person_info
                   file_name file_name_structure body_section supports_preview
                   is_embedded content_disposition content_id message_id
                   email_message_id gmail_message_id gmail_thread_id email_addresses
                   created first_name id last_name resource_url sources is_tnef_part)

    private
    attr_reader :connection

    public
    attr_reader :parent, :response, :status, :success, :file_id, :response, *FILE_READERS
    def initialize(parent:,
                   identifier: nil,
                   response: nil,
                   status: nil,
                   success: nil,
                   api_call_made: nil)
      @parent = parent
      @connection = parent.connection
      @file_id = identifier
      @status = status
      @success = success
      @api_call_made = api_call_made
      if response
        parse_response(response)
      end
    end

    def call_url
      build_url("files", file_id)
    end

    def valid_content_params
      ValidParams::GET_FILES_CONTENT_PARAMS
    end

    def content(**kwargs)
      url = "#{call_url}/content"
      valid_params = get_params(kwargs, valid_content_params)
      resp = Request.new(connection, :get, url, valid_params)
      Files.new(parent: parent,
                identifier: file_id,
                response: resp.response,
                status: resp.status,
                success: resp.success)
    end

    def related
      call_api("#{call_url}/related")
    end
  end
end
