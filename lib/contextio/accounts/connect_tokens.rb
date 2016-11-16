class ConnectTokens
  attr_reader :response, :raw_response, :success
  def initialize(response, raw_response, success = true)
    @response = response
    @raw_response = raw_response
    @success = success
  end

  def success?
    @success
  end

  def self.fetch(connection, account_id, id, method)
    raw_response = connection.connect.send(method, "/2.0/accounts/#{account_id}/connect_tokens/#{id}").body
    response = JSON.parse(raw_response)
    ConnectTokens.new(response, raw_response, valid_id?(response))
  end

  def self.valid_id?(response)
    !response.empty?
  end
end
