module ContextIO
  class Request
    require "json"
    attr_reader :response, :status, :success
    def initialize(connection, method, url, params)
      request = connection.connect.send(method, url, params)
      if request.headers["content-type"] == "application/json"
        @response = JSON.parse(request.body)
      else
        @response = request.body
      end
      @status = request.status
      @success =  check_success(request.status)
    end

    def check_success(status)
      status >= 200 && status <= 299
    end
  end
end
