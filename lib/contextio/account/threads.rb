class Threads
  private
  attr_reader :context_io

  public
  include RequestHelper
  attr_reader :response, :status, :success, :account_id, :thread_id
  def initialize(context_io:,
                 account_id:,
                 identifier: nil,
                 response: nil,
                 status: nil,
                 success: nil)
    @context_io = context_io
    @account_id = account_id
    @thread_id = identifier
    @response = response
    @status = status
    @success =  success
  end
end
