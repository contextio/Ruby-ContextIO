class Request
  attr_reader :response, :status, :success
  def initialize(connection, method, url, klass = nil, account_id = nil)
    request = connection.connect.send(method, url)
    @response = JSON.parse(request.body)
    @status = request.status
    @success =  check_success(request.status)
  end

  def check_success(status)
    status >= 200 && status <= 299
  end
end
