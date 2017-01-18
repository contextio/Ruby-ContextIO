module ContextIO
  module CollectionHelper
    def collection_return(url, params, parent, klass)
      request = Request.new(connection, :get, url, params)
      request.response.map do |resp|
        klass.new(parent: parent,
                  response: resp,
                  status: request.status,
                  success: request.success)
      end
    end

    def contact_collection_return(url)
      request = Request.new(connection, :get, url)
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
  end
end
