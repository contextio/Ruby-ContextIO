class Contacts
  attr_reader :response, :raw_response, :status, :success, :connection, :account_id
  def initialize(response, raw_response, status, success = true, connection = nil, account_id = nil)
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
    response = ResponseUtility.new(connection,
                                   method,
                                   "/2.0/accounts/#{account_id}/contacts/#{id}")
    Contacts.new(response.parsed_response_body,
                 response.raw_response_body,
                 response.status,
                 response.success,
                 connection,
                 account_id)
  end
end
