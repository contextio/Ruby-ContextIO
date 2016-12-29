require_relative "contextio/base_class"
Dir["./lib/contextio/*.rb"].each {|file| require file }
Dir["./lib/contextio/**/*.rb"].each {|file| require file }

require "json"

module ContextIO
  class ContextIO
    include CollectionHelper
    attr_reader :connection, :call_url, :version
    def initialize(key:, secret:, version:)
      @connection = Connection.new(key, secret)
      @call_url = "/#{version}"
      @version = version
    end

    def collection_return(request, klass)
      request.response.map do |resp|
        klass.new(parent: self,
                  response: resp,
                  status: request.status,
                  success: request.success)
      end
    end

    def get_accounts
      request = Request.new(connection, :get, "#{call_url}/accounts")
      collection_return(request, Account)
    end

    def get_oauth_providers
      request = Request.new(connection, :get, "#{call_url}/oauth_providers")
      collection_return(request, OauthProvider)
    end
  end
end
