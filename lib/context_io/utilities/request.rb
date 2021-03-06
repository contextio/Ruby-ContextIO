module ContextIO
  class Request
    require "json"
    attr_reader :response, :status, :success, :url
    def initialize(connection, method, url, params = nil)
      request = connection.connect.send(method, url, params)
      if request.headers["content-type"] == "application/json"
        @response = JSON.parse(request.body)
      else
        @response = request.body
      end
      @url = request.env.url
      @status = request.status
      @success =  check_success(request.status)
    end

    def check_success(status)
      status >= 200 && status <= 299
    end
  end
end
