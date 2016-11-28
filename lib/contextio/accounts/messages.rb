class Messages
  attr_reader :response, :status, :success
  def initialize(response, status, success = true)
    @response = response
    @status = status
    @success = success
  end

  def success?
    @success
  end

  def self.fetch(connection, account_id, id, method)
    request = Request.new(connection,
                          method,
                          "/2.0/accounts/#{account_id}/messages/#{id}")
    Messages.new(request.response,
                 request.status,
                 request.success)
  end
end
