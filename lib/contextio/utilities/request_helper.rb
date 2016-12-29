module ContextIO
  module RequestHelper
    def collection_return(request, parent, klass)
      request.response.map do |resp|
        klass.new(parent: parent,
                  response: resp,
                  status: request.status,
                  success: request.success)
      end
    end

    def contact_collection_return(request, parent)
      response = request.response
      matches = response["matches"].map do |resp|
        Contact.new(response: resp,
                    status: request.status,
                    success: request.success,
                    parent: parent,
                    identifier: resp["email"])
      end
      [response["query"], matches]
    end

    def parse_response(response)
      response.each { |k,v| instance_variable_set("@#{k}", v) }
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

    def check_success(status)
      status >= 200 && status <= 299
    end

    def success?
      self.success
    end
  end
end
