module ContextIO
  class BaseClass
    def parse_response(response)
      if response.class == String
        @response = response
      else
        response.each { |k,v| instance_variable_set("@#{k}", v) }
      end
    end

    def build_url(resource, identifier)
      "#{parent.call_url}/#{resource}/#{identifier}"
    end

    def call_api
      request = Request.new(connection, :get, call_url)
      parse_response(request.response)
      @status = request.status
      @success = check_success(status)
      self
    end

    def get
      call_api
    end

    def check_success(status)
      status >= 200 && status <= 299
    end

    def success?
      self.success
    end
  end
end
