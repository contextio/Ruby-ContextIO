class Files
  private
  attr_reader  :request, :connection

  public
  include RequestHelper
  def initialize(request, connection = nil)
    @request = request
    @connection = connection
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
