class Contacts
  attr_reader :response, :raw_response, :status, :success, :connection, :account_id
  def initialize(response, raw_response, status, success = true, connection, account_id)
    @response = response
    @raw_response = raw_response
    @status = status
    @success = success
    @connection = connection
    @account_id = account_id
  end

  def files(email = nil, method = :get)
    Files.contacts_fetch(connection,
                         account_id,
                         email,
                         method)

  end

  def success?
    @success
  end

  def self.fetch(connection, account_id, id, method)
    raw_response = connection.connect.send(method,
                                           "/2.0/accounts/#{account_id}/contacts/#{id}")
    status = raw_response.status.to_s
    raw_response_body = raw_response.body
    parsed_response_body = JSON.parse(raw_response_body)
    Contacts.new(parsed_response_body,
                 raw_response_body,
                 status,
                 check_success?(status),
                 connection,
                 account_id)
  end

  def self.check_success?(status)
    status == "200"
  end
end
