module ContextIO
  class Sync
    include ContextIO::CallHelpers
    private
    attr_reader :parent

    public
    attr_reader :status, :success, :connection, :response, :api_call_made
    def initialize(parent:,
                   response: nil,
                   status: nil,
                   success: nil,
                   api_call_made: nil)
      @parent = parent
      @connection = parent.connection
      @response = response
      @status = status
      @success = success
      @api_call_made = api_call_made
    end

    def call_url
      "#{parent.call_url}/sync"
    end

    def get
      request = Request.new(connection, :get, call_url)
      @response = request.response
      @status = request.status
      @success = check_success(status)
      self
    end
  end
end
