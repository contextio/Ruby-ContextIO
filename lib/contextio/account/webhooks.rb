module ContextIO
  class Webhooks < BaseClass
    private
    attr_reader :connection, :account_id, :webhook_id

    public
    attr_reader :response, :status, :success
    def initialize(request, connection, account_id = nil, webhook_id = nil)
      @response = request.response
      @status = request.status
      @success =  request.success
      @connection = connection
      @account_id = account_id
      @webhook_id = webhook_id
    end

    def self.fetch(connection, id: nil, method: :get)
      Webhooks.new(Request.new(connection,
                               method,
                               "/2.0/webhooks/#{id}"),
                               connection)
    end
  end
end
