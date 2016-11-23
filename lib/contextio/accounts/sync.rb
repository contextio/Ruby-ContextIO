class Sync
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
    response = ResponseUtility.new(connection,
                                   method,
                                   "/2.0/accounts/#{account_id}/sync/#{id}")
    Sync.new(response.parsed_response_body,
             response.raw_response_body,
             resposne.status,
             resposne.success)
  end
end
