module ContextIO
  class BaseClass
    def parse_response(response)
      if response.is_a? String
        @response = response
      elsif response.is_a? Array
        response.each do |index|
          key = k.to_s.gsub('-', '_')
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

    def call_api(url = nil)
      request = Request.new(connection, :get, url || call_url)
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
