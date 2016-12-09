class Request
  attr_reader :response, :status, :success
  def initialize(connection, method, url, klass = nil, account_id = nil)
    request = connection.connect.send(method, url)
    if klass.to_s == "Contacts"
      @response =  contact_response(request, connection, account_id)
    elsif klass
      @response = collection_return(request, klass, connection, account_id)
    else
      @response = JSON.parse(request.body)
    end
    @status = request.status
    @success =  check_success(request.status)
  end

  def contact_response(request, connection, account_id)
    responses = JSON.parse(request.body)
    contacts_array = responses["matches"].map do |match|
      Contacts.new(ResponseStruct.new(match, request.status, check_success(request.status)),
                   connection,
                   account_id)
    end
    [responses["query"], contacts_array]
  end

  def collection_return(request, klass, connection, account_id)
    responses = JSON.parse(request.body)
    responses.map do |resp|
      klass.new(ResponseStruct.new(resp,
                                   request.status,
                                   check_success(request.status)),
                                   connection,
                                   account_id || resp["id"])
    end
  end

  def check_success(status)
    status >= 200 && status <= 299
  end
end
