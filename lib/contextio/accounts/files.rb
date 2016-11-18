class Files
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
    raw_response = connection.connect.send(method, "/2.0/accounts/#{account_id}/files/#{id}")
    status = raw_response.status.to_s
    raw_response_body = raw_response.body
    parsed_response_body = JSON.parse(raw_response_body)
    Files.new(parsed_response_body,
              raw_response_body,
              status,
              check_success?(status))
  end

  def self.check_success?(status)
    status == "200"
  end
end
