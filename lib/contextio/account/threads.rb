module ContextIO
  class Threads < BaseClass
    private
    attr_reader :parent

    public
    attr_reader :response, :status, :success, :account_id, :thread_id
    def initialize(parent:,
                   account_id: nil,
                   identifier: nil,
                   response: nil,
                   status: nil,
                   success: nil)
      @parent = parent
      @account_id = account_id
      @thread_id = identifier
      @response = response
      @status = status
      @success =  success
    end
  end
end
