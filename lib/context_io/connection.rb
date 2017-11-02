require "faraday"
require "faraday_middleware"

module ContextIO
  class Connection
    ROOT_URL = "https://api.context.io"
    USER_AGENT = "context_io-ruby-2.0"

    attr_reader :key, :secret
    def initialize(key, secret)
      @key = key
      @secret = secret
    end

    def connect
      @connection ||= Faraday::Connection.new(ROOT_URL) do |f|
        f.headers["User-Agent"] = USER_AGENT
        f.request :oauth, consumer_key: key, consumer_secret: secret
        f.request :url_encoded
        f.request :retry, max: 0
        f.adapter Faraday.default_adapter
      end
    end
  end
end
