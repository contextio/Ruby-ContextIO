class CollectionRequest
  attr_reader :response, :status, :success
  def initialize(connection, method, url, klass, account_id)
    request = connection.connect.send(method, url)
    @response = collection_return(request, connection, klass, account_id)
    @status = request.status
    @success =  check_success(request.status)
  end

  def collection_return(request, connection, klass, account_id)
    responses = JSON.parse(request.body)
    if klass.to_s == "Contacts"
      query = responses["query"]
      responses = responses["matches"]
    end
    responses = responses.map do |resp|
      klass.new(ResponseStruct.new(resp,
                                   request.status,
                                   check_success(request.status)),
                                   connection,
                                   account_id || resp["id"])
    end
    if query
      [query, responses]
    else
      response
    end
  end

  def check_success(status)
    status >= 200 && status <= 299
  end
end
