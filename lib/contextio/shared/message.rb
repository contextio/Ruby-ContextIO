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
    attr_accessor :api_call_made
    attr_reader :status, :success, :connection, :message_id, :response, *MESSAGE_READERS
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

    def parent_not_account_error
      raise StandardError, "This method can only be called from '2.0/accounts/:account/message/:message_id'" if parent.class != Account
    end

    def get(**kwargs)
      get_request(given_params: kwargs, valid_params: ValidGetParams::MESSAGE)
    end

    def post(dst_folder:, **kwargs)
      parent_not_account_error
      given_params = kwargs.merge(dst_folder: dst_folder)
      token = call_api_return_updated_object(klass: Message,
                                             url: "#{call_url}",
                                             identifier: encoded_message_id,
                                             method: :post,
                                             valid_params: ValidPostParams::MESSAGE_MOVE_20,
                                             given_params: given_params)
      return_post_api_call_made(token)
    end

    def body(**kwargs)
      call_api_return_new_object(klass: Message,
                                 url: "#{call_url}/body",
                                 valid_params: ValidGetParams::MESSAGE_BODY,
                                 given_params: kwargs)
    end

    def flags
      call_api_return_new_object(klass: Message,
                                 url: "#{call_url}/flags")
    end

    def folders
      call_api_return_new_object(klass: Message,
                                 url: "#{call_url}/folders")
    end

    def headers(**kwargs)
      call_api_return_new_object(klass: Message,
                                 url: "#{call_url}/headers",
                                 valid_params: ValidGetParams::MESSAGE_HEADER,
                                 given_params: kwargs)
    end

    def source
      call_api_return_new_object(klass: Message,
                                 url: "#{call_url}/source")
    end

    def threads(**kwargs)
      call_api_return_new_object(klass: Message,
                                 url: "#{call_url}/thread",
                                 valid_params: ValidGetParams::MESSAGE_THREADS,
                                 given_params: kwargs)
    end
  end
end
