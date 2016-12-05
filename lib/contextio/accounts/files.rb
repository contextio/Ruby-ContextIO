class Files
  private
  attr_reader  :connection

  public
  include RequestHelper
  attr_reader :response, :status, :success
  def initialize(request,
                 connection = nil)
    @response = request.response
    @status = request.status
    @success =  request.success
    @connection = connection
  end

  def self.contacts_fetch(connection, account_id, email, method)
    url =  "/2.0/accounts/#{account_id}/contacts/#{email}/files"
    Files.new(Request.new(connection, method, url))
  end

  def self.fetch(connection, account_id, email, method)
    url =  "/2.0/accounts/#{account_id}/files/#{email}"
    Files.new(Request.new(connection, method, url))
  end
end
