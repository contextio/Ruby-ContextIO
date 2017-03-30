module ContextIO
  module CollectionHelper
    def collection_return(url:,
                          klass:,
                          method: :get,
                          valid_params: nil,
                          given_params: nil)
      request, api_call_made = call_api(method: :get,
                                        url: url,
                                        given_params: given_params,
                                        valid_params:valid_params)
      request.response.map do |resp|
        klass.new(parent: self,
                  response: resp,
                  status: request.status,
                  success: request.success,
                  api_call_made: api_call_made)
      end
    end

    def contact_collection_return(url:,
                                  method: :get,
                                  valid_params: nil,
                                  given_params: nil)
      request, api_call_made = call_api(method: :get,
                                        url: url,
                                        given_params: given_params,
                                        valid_params:valid_params)
      response = request.response
      matches = response["matches"].map do |resp|
        Contact.new(response: resp,
                    status: request.status,
                    success: request.success,
                    parent: self,
                    identifier: resp["email"],
                    api_call_made: api_call_made)
      end
      [response["query"], matches]
    end
  end
end
