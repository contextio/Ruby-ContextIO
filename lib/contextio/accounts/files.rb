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
    Files.new(Request.new(connection, method, url))
  end

  def self.fetch(connection, account_id, email, method)
    url =  Request.determine_api_endpoint(account_id, email, "files")
    Files.new(Request.new(connection, method, url))
  end
end
