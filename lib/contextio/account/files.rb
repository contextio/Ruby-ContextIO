class Files
  FILE_ATTRS = %I(size type subject date date_indexed addresses person_info
                 file_name file_name_structure body_section file_id supports_preview
                 is_embedded content_disposition content_id message_id
                 email_message_id gmail_message_id gmail_thread_id)

  private
  attr_reader :context_io

  public
  include RequestHelper
  attr_reader :response, :status, :success, :account_id, :file_id, *FILE_ATTRS
  def initialize(context_io:,
                 account_id:,
                 identifier:,
                 response: nil,
                 status: nil,
                 success: nil)
    @context_io = context_io
    @account_id = account_id
    @file_id = identifier
    @status = status
    @success =  success
    if response
      response.each { |k,v| instance_variable_set("@#{k}", v) }
    end
  end
end
