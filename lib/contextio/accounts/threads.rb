class Threads
  attr_reader :response, :raw_response, :status, :success
  def initialize(response, raw_response, status, success = true)
    @response = response
    @raw_response = raw_response
    @status = status
    @success = success
  end

  def success?
    @success
  end

  def self.fetch(connection, account_id, id, method)
    response = ResposneUtility.new(connection,
                                   method,
                                   "/2.0/accounts/#{account_id}/threads/#{id}")
    Threads.new(response.parsed_response_body,
                response.raw_response_body,
                response.status,
                response.check_success?(status))
  end
end
