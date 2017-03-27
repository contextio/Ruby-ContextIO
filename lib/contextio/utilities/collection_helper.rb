module ContextIO
  module CollectionHelper
    def collection_return(url, parent, klass, valid_params = nil, given_params = nil)
      allowed_params, rejected_params = get_params(given_params, valid_params)
      request = Request.new(connection, :get, url, allowed_params)
      raise StandardError, build_error_message(request.status, request.response) if request.success == false
      api_call_made = APICallMade::CALL_MADE_STRUCT.new(request.url,
                                                        allowed_params,
                                                        rejected_params)
      request.response.map do |resp|
        klass.new(parent: self,
                  response: resp,
                  status: request.status,
                  success: request.success,
                  api_call_made: api_call_made)
      end
    end

    def contact_collection_return(url, valid_params = nil, given_params = nil)
      allowed_params, rejected_params = get_params(given_params, valid_params)
      request = Request.new(connection, :get, url, allowed_params)
      raise StandardError, build_error_message(request.status, request.response) if request.success == false
      api_call_made = APICallMade::CALL_MADE_STRUCT.new(request.url,
                                                        allowed_params,
                                                        rejected_params)
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
