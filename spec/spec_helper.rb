$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "contextio"
require "webmock/rspec"

require_relative "./contextio/mock_response.rb"

REQUEST_ENDPOINTS = [
  "accounts",
  "accounts/some_id",
  "accounts/12345/connect_tokens",
  "accounts/12345/contacts",
  "accounts/12345/email_addresses",
  "accounts/12345/files",
  "accounts/12345/messages",
  "accounts/12345/sources",
  "accounts/12345/sync",
  "accounts/12345/threads",
  "accounts/12345/webhooks"
  ]

WebMock.disable_net_connect!(allow_localhost: true)
RSpec.configure do |config|
  config.before(:each) do
    REQUEST_ENDPOINTS.each do |endpoint|
      stub_request(:get, "https://api.context.io/2.0/#{endpoint}").
        with(headers: {'Accept'=>'*/*', "User-Agent" => "contextio-ruby-2.0"}).
        to_return(status: 200, body: MockResponse::MOCK_FARADAY_OBJECT_SUCCESS_BODY, headers: {})
      end
  end
end
