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
    url =  ResponseUtility.determine_api_endpoint(account_id, email, "contacts", true)
    response = ResponseUtility.new(connection, method, url)
    Files.new(response.parsed_response_body,
              response.raw_response_body,
              response.status,
              response.success)
  end

  def self.fetch(connection, account_id, email, method)
    url =  ResponseUtility.determine_api_endpoint(account_id, email, "files")
    response = ResponseUtility.new(connection, method, url)
    Files.new(response.parsed_response_body,
              response.raw_response_body,
              response.status,
              response.success)
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
end
