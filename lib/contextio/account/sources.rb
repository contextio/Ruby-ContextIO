module ContextIO
  class Sources < BaseClass
    private
    attr_reader :connection, :account_id, :label

    public
    include CollectionHelper
    attr_reader :response, :status, :success
    def initialize(request, connection, account_id = nil, label = nil)
      @response = request.response
      @status = request.status
      @success =  request.success
      @connection = connection
      @account_id = account_id
      @label = label
    end
  end
end
