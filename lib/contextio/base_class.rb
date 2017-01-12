module ContextIO
  class BaseClass
    require_relative './utilities/collection_helper.rb'
    include ContextIO::CollectionHelper
    def parse_response(response)
      if response.is_a? String
        @response = response
      elsif response.is_a? Array
        response.each do |index|
          index.each do |k,v|
            key = k.to_s.gsub('-', '_')
            instance_variable_set("@#{key}", v)
          end
        end
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

    def call_collection_endpoint(url = nil)
      request = Request.new(connection, :get, url || call_url)
      parse_response(request.response)
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
