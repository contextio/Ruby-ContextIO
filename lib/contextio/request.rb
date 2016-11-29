#TODO: Pass in the class instead of Creating it outside of the request
class Request
  attr_reader :response, :status, :success
  def initialize(connection, method, url)
    request = connection.connect.send(method, url)
    @status = request.status
    @response = JSON.parse(request.body)
    @success =  check_success(request.status)
  end

  def check_success(status)
    status >= 200 && status <= 299
  end
end
