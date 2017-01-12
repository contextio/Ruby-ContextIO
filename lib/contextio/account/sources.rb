module ContextIO
  class Sources < BaseClass
  SOURCE_READERS = %I(username status type label use_ssl resource_url server
                      port mailserviceAccountId callbackUrl delimiter
                      authentication_type sync_flags type)

    private
    attr_reader :parent

    public
    include CollectionHelper
    attr_reader :status, :success, :connection, :message_id, *SOURCE_READERS
    def initialize(parent:,
                   identifier: nil,
                   response: nil,
                   status: nil,
                   success: nil)
      @status = status
      @success =  success
      @parent = parent
      @connection = parent.connection
      @label = identifier
      if response
        parse_response(response)
      end
    end

    def parse_response(response)
      if response.is_a? String
        @response = response
      elsif response.is_a? Array
        return_array = []
        response.each do |index|
          return_array << Sources.new(parent: parent, identifier: label, response: index)
        end
        return_array
      else
        response.each do |k,v|
          key = k.to_s.gsub('-', '_')
          instance_variable_set("@#{key}", v)
        end
      end
    end

    def call_url
      build_url("sources", label)
    end

    def folders(folder: nil)
      if folder
        call_instance_endpoint("#{call_url}/folders/#{folder}")
      else
        call_collection_endpoint("#{call_url}/folders")
      end
    end
  end
end
