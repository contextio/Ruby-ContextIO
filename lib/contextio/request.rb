class Request
  attr_reader :response, :status, :success
  def initialize(connection, method, url, klass = nil)
    request = connection.connect.send(method, url)
    if klass
      @response = collection_return(request, klass, connection)
    else
      @response = JSON.parse(request.body)
    end
    @status = request.status
    @success =  check_success(request.status)
  end

  def collection_return(request, klass, connection)
    responses = JSON.parse(request.body)
    responses.map do |resp|
      Accounts.new(ResponseStruct.new(resp, request.status, check_success(request.status)), connection)
    end
  end

  def check_success(status)
    status >= 200 && status <= 299
  end
end
