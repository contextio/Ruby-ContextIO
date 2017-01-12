module ContextIO
  class BaseClass
    require_relative './utilities/collection_helper.rb'
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

    def call_instance_endpoint(url = nil)
      request = Request.new(connection, :get, url || call_url)
      parse_response(request.response)
      @status = request.status
      @success = check_success(status)
      self
    end

    def call_collection_endpoint(url, klass)
      request = Request.new(connection, :get, url || call_url)
      collection_return(request, self ,klass)
    end

    def get
      call_instance_endpoint
    end

    def check_success(status)
      status >= 200 && status <= 299
    end

    def success?
      self.success
    end
  end
end
