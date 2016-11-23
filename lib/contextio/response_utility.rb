#TODO: Rename to request
#TODO: Pass in the class instead of Creating it outside of the request
class ResponseUtility
  attr_reader :parsed_response_body, :raw_response_body, :status, :success
  def initialize(connection, method, url)
    response = connection.connect.send(method, url)
    @raw_response_body = response.body
    @status = response.status
    @parsed_response_body = JSON.parse(raw_response_body)
    @success =  check_success?(response.status)
  end

  def self.determine_api_endpoint(account_id, identifier, parent_resouce, from_a_contact = false)
    if from_a_contact
      "/2.0/accounts/#{account_id}/#{parent_resouce}/#{identifier}/files"
    elsif identifier
      "/2.0/accounts/#{account_id}/#{parent_resouce}/#{identifier}"
    else
      "/2.0/accounts/#{account_id}/#{parent_resouce}"
    end
  end

  def check_success?(status)
    status >= 200 && status <= 299
  end
end
