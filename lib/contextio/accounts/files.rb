class Files
  attr_reader :response, :raw_response, :status, :success, :connection
  def initialize(response, raw_response, status, success = true, connection = nil)
    @response = response
    @raw_response = raw_response
    @status = status
    @success = success
    @connection = connection
  end

  def success?
    @success
  end

  def self.contacts_fetch(connection, account_id, email, method)
    url =  determine_api_endpoint(account_id,
                                  email,
                                  "contacts",
                                  true)
    raw_response = connection.connect.send(method, url)
    status = raw_response.status.to_s
    raw_response_body = raw_response.body
    parsed_response_body = JSON.parse(raw_response_body)
    Files.new(parsed_response_body,
              raw_response_body,
              status,
              check_success?(status))
  end

  def self.fetch(connection, account_id, email, method)
    url =  determine_api_endpoint(account_id, email, "files")
    raw_response = connection.connect.send(method, url)
    status = raw_response.status.to_s
    raw_response_body = raw_response.body
    parsed_response_body = JSON.parse(raw_response_body)
    Files.new(parsed_response_body,
              raw_response_body,
              status,
              check_success?(status))
  end

  def self.determine_api_endpoint(account_id, email, parent_resouce, from_a_contact = false)
    if from_a_contact
      "/2.0/accounts/#{account_id}/#{parent_resouce}/#{email}/files"
    elsif email
      "/2.0/accounts/#{account_id}/#{parent_resouce}/#{email}"
    else
      "/2.0/accounts/#{account_id}/#{parent_resouce}"
    end
  end

  def self.check_success?(status)
    status == "200"
  end
end
