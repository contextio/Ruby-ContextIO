module ContextIO
  class Files
    include ContextIO::CallHelpers
    FILE_READERS = %I(size type subject date date_indexed addresses person_info
                   file_name file_name_structure body_section supports_preview
                   is_embedded content_disposition content_id message_id
                   email_message_id gmail_message_id gmail_thread_id email_addresses
                   created first_name id last_name resource_url sources is_tnef_part)

    private
    attr_reader :parent

    public
    attr_reader :connection, :response, :status, :success, :file_id, :api_call_made, *FILE_READERS
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

    def contact_url?
      parent.call_url.include?("/contacts/")
    end

    def contact_url_error
      raise StandardError, "This method can only be called from '2.0/accounts/:account/file/:file_id'" if contact_url?
    end

    def content(**kwargs)
      contact_url_error
      call_api_return_new_object(Files, file_id, "#{call_url}/content", ValidGetParams::FILE_CONTENT, kwargs)
    end

    def related
      contact_url_error
      call_api(url: "#{call_url}/related")
    end
  end
end
