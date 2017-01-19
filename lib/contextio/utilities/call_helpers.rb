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

    def call_api(kwargs = nil, url = nil)
      valid_params = Array( (valid_get_params if self.respond_to?(:valid_get_params)) )
      params = get_params(kwargs, valid_params)
      request = Request.new(connection, :get, url || call_url, params)
      parse_response(request.response)
      @status = request.status
      @success = check_success(status)
      self
    end

    def call_api_return_new_class(klass, identifier)
      klass.new(parent: self, identifier: identifier).get
    end

    def get_params(inputed_params, valid_params)
      params = inputed_params.map do |key, value|
        if valid_params.include?(key)
          [key, value]
        end
      end
      params.compact!
      if !params.empty?
        params = params.to_h
      end
    end

    def get(**kwargs)
      call_api(kwargs)
    end

    def check_success(status)
      status >= 200 && status <= 299
    end

    def success?
      self.success
    end
  end
end
