#TODO: Pass in the class instead of Creating it outside of the request
class Request
  attr_reader :response, :status, :success
  def initialize(connection, method, url)
    request = connection.connect.send(method, url)
    @status = request.status
    @response = JSON.parse(request.body)
    @success =  check_success(request.status)
  end

#TODO: Pass in the give the URL, don't decide the URL
  def self.determine_api_endpoint(account_id, identifier, parent_resouce, from_a_contact = false)
    if from_a_contact
      "/2.0/accounts/#{account_id}/#{parent_resouce}/#{identifier}/files"
    elsif identifier
      "/2.0/accounts/#{account_id}/#{parent_resouce}/#{identifier}"
    else
      "/2.0/accounts/#{account_id}/#{parent_resouce}"
    end
  end

  def check_success(status)
    status >= 200 && status <= 299
  end
end
