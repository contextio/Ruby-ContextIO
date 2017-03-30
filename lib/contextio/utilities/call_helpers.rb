module ContextIO
  module CallHelpers
    require_relative './collection_helper.rb'
    include ContextIO::CollectionHelper
    def parse_response(response)
      if [Array, String].include?(response.class)
        @response = response
      else
        response.each do |k,v|
          key = k.to_s.gsub('-', '_')
          instance_variable_set("@#{key}", v)
        end
      end
    end

    def build_url(resource, identifier)
      "#{parent.call_url}/#{resource}/#{identifier}"
    end

    def get_request(given_params: nil, valid_params: nil, url: nil)
      request, api_call_made = call_api(method: :get,
                                         url: url || call_url,
                                         given_params: given_params,
                                         valid_params:valid_params)
      parse_response(request.response)
      @status = request.status
      @success = check_success(status)
      @api_call_made = api_call_made
      self
    end

    def call_api_return_new_object(klass:,
                                   url:,
                                   method: :get,
                                   identifier: nil,
                                   valid_params: nil,
                                   given_params: nil)
      allowed_params, rejected_params = validate_params(given_params, valid_params)
      request = Request.new(connection, method, url, allowed_params)
      raise StandardError, build_error_message(request.status, request.response) if request.success == false
      api_call_made = build_api_call_made(request.url,
                                          method,
                                          allowed_params,
                                          rejected_params)
      klass.new(parent: self,
                response: request.response,
                status: request.status,
                success: request.success,
                api_call_made: api_call_made)
    end

    def validate_params(inputed_params, valid_params)
      return [nil, nil] if inputed_params.nil?
      rejected_params = []
      params = []
      inputed_params.map do |key, value|
        if valid_params.include?(key)
          params << [key, value]
        else
          rejected_params << key
        end
      end
      params = params.compact
      if !params.empty?
        params = params.to_h
      end
      [params, rejected_params]
    end

    def get(**kwargs)
      get_request(given_params: kwargs)
    end

    def delete
      request = Request.new(connection, :delete, call_url)
      raise StandardError, build_error_message(request.status, request.response) if request.success == false
      api_call_made = build_api_call_made(request.url,
                                          :delete,
                                          nil,
                                          nil)
      DeletedResource.new(response: request.response,
                          status: request.status,
                          success: request.success,
                          api_call_made: api_call_made)
    end

    def success?
      self.success
    end

    private

    def call_api(method:, url:, given_params:, valid_params:)
      allowed_params, rejected_params = validate_params(given_params, valid_params)
      request = Request.new(connection, method, url || call_url, allowed_params)
      raise StandardError, build_error_message(request.status, request.response) if request.success == false
      api_call_made = build_api_call_made(request.url,
                                          method,
                                          allowed_params,
                                          rejected_params)
      [request, api_call_made]
    end

    def check_success(status)
      status >= 200 && status <= 299
    end

    def build_api_call_made(url, method, allowed_params, rejected_params)
      APICallMade::CALL_MADE_STRUCT.new(url,
                                        method,
                                        allowed_params,
                                        rejected_params)
    end

    def build_error_message(status, body)
      if body.empty?
        "HTTP code #{status}. No API error given."
      else
        "HTTP code #{status}. Response #{body}"
      end
    end
  end
end
