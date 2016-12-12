class Sources
  private
  attr_reader :connection, :account_id, :label

  public
  include RequestHelper
  attr_reader :response, :status, :success
  def initialize(request, connection, account_id, label)
    @response = request.response
    @status = request.status
    @success =  request.success
    @connection = connection
    @account_id = account_id
    @label = label
  end

  def self.fetch(connection, account_id, id, method)
    Sources.new(Request.new(connection,
                            method,
                            "/2.0/accounts/#{account_id}/sources/#{id}"),
                            connection,
                            account_id)
  end
end
