module ContextIO
  module RequestHelper
    def collection_return(request, parent, klass, account_id)
      request.response.map do |resp|
        klass.new(parent: parent,
                  account_id: account_id,
                  response: resp,
                  status: request.status,
                  success: request.success)
      end
    end

    def contact_collection_return(request, parent, account_id)
      response = request.response
      matches = response["matches"].map do |resp|
        Contact.new(response: resp,
                    status: request.status,
                    success: request.success,
                    parent: parent,
                    identifier: resp["email"],
                    account_id: account_id)
      end
      [response["query"], matches]
    end

    def parse_response(response)
      response.each { |k,v| instance_variable_set("@#{k}", v) }
    end

    def check_success(status)
      status >= 200 && status <= 299
    end

    def success?
      self.success
    end
  end
end
