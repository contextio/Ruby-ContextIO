$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "contextio"
require "webmock/rspec"

require_relative "./contextio/mock_response.rb"
WebMock.disable_net_connect!(allow_localhost: true)
#TODO: .each an array of endpoints
RSpec.configure do |config|
  config.before(:each) do
    stub_request(:get, "https://api.context.io/2.0/accounts").
      with(headers: {'Accept'=>'*/*', "User-Agent" => "contextio-ruby-2.0"}).
      to_return(status: 200, body: MockResponse::MOCK_FARADAY_OBJECT_SUCCESS_BODY, headers: {})

    stub_request(:get, "https://api.context.io/2.0/accounts/some_id").
      with(headers: {'Accept'=>'*/*', "User-Agent" => "contextio-ruby-2.0"}).
      to_return(status: 200, body: MockResponse::MOCK_FARADAY_OBJECT_SUCCESS_BODY, headers: {})

    stub_request(:get, "https://api.context.io/2.0/accounts/12345/connect_tokens/").
      with(headers: {'Accept'=>'*/*', "User-Agent" => "contextio-ruby-2.0"}).
      to_return(status: 200, body: MockResponse::MOCK_FARADAY_OBJECT_SUCCESS_BODY, headers: {})

    stub_request(:get, "https://api.context.io/2.0/accounts/12345/contacts/").
      with(headers: {'Accept'=>'*/*', "User-Agent" => "contextio-ruby-2.0"}).
      to_return(status: 200, body: MockResponse::MOCK_FARADAY_OBJECT_SUCCESS_BODY, headers: {})

    stub_request(:get, "https://api.context.io/2.0/accounts/12345/email_addresses/").
      with(headers: {'Accept'=>'*/*', "User-Agent" => "contextio-ruby-2.0"}).
      to_return(status: 200, body: MockResponse::MOCK_FARADAY_OBJECT_SUCCESS_BODY, headers: {})

    stub_request(:get, "https://api.context.io/2.0/accounts/12345/files/").
      with(headers: {'Accept'=>'*/*', "User-Agent" => "contextio-ruby-2.0"}).
      to_return(status: 200, body: MockResponse::MOCK_FARADAY_OBJECT_SUCCESS_BODY, headers: {})

    stub_request(:get, "https://api.context.io/2.0/accounts/12345/messages/").
      with(headers: {'Accept'=>'*/*', "User-Agent" => "contextio-ruby-2.0"}).
      to_return(status: 200, body: MockResponse::MOCK_FARADAY_OBJECT_SUCCESS_BODY, headers: {})

    stub_request(:get, "https://api.context.io/2.0/accounts/12345/sources/").
      with(headers: {'Accept'=>'*/*', "User-Agent" => "contextio-ruby-2.0"}).
      to_return(status: 200, body: MockResponse::MOCK_FARADAY_OBJECT_SUCCESS_BODY, headers: {})

    stub_request(:get, "https://api.context.io/2.0/accounts/12345/sync/").
      with(headers: {'Accept'=>'*/*', "User-Agent" => "contextio-ruby-2.0"}).
      to_return(status: 200, body: MockResponse::MOCK_FARADAY_OBJECT_SUCCESS_BODY, headers: {})

    stub_request(:get, "https://api.context.io/2.0/accounts/12345/threads/").
      with(headers: {'Accept'=>'*/*', "User-Agent" => "contextio-ruby-2.0"}).
      to_return(status: 200, body: MockResponse::MOCK_FARADAY_OBJECT_SUCCESS_BODY, headers: {})

    stub_request(:get, "https://api.context.io/2.0/accounts/12345/webhooks/").
      with(headers: {'Accept'=>'*/*', "User-Agent" => "contextio-ruby-2.0"}).
      to_return(status: 200, body: MockResponse::MOCK_FARADAY_OBJECT_SUCCESS_BODY, headers: {})
  end
end
