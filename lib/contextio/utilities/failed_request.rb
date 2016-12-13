class FailedRequest
  include RequestHelper
  attr_reader :response, :status, :success
  def initialize(failure_string)
    @response = failure_string
    @status = nil
    @success = false
  end
end
