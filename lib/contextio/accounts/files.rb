class Files
  private
  attr_reader :connection

  public
  attr_reader :response, :status, :success
  def initialize(response, status, success = true, connection = nil)
    @response = response
    @status = status
    @success = success
    @connection = connection
  end

  def success?
    @success
  end

  def self.contacts_fetch(connection, account_id, email, method)
    url =  Request.determine_api_endpoint(account_id, email, "contacts", true)
    request = Request.new(connection, method, url)
    Files.new(request.response,
              request.status,
              request.success)
  end

  def self.fetch(connection, account_id, email, method)
    url =  Request.determine_api_endpoint(account_id, email, "files")
    request = Request.new(connection, method, url)
    Files.new(request.response,
              request.status,
              request.success)
  end
end
