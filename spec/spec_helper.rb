require 'simplecov'
SimpleCov.start

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "contextio"
require "webmock/rspec"

require_relative "./contextio/utilities/mock_response.rb"

ACCOUNT_REQUEST_ENDPOINTS = [
  "accounts/some_id",
  "accounts/some_id/connect_tokens/some_token_id",
  "accounts/some_id/contacts/some_email@some_provider.com",
  "accounts/some_id/email_addresses/some_email@some_provider.com",
  "accounts/some_id/messages",
  "accounts/some_id/sources",
  "accounts/some_id/sync",
  "accounts/some_id/threads",
  "accounts/some_id/webhooks",
  "accounts/some_id/files/some_file",
  "accounts/some_id/files/some_file/related",
  "accounts/some_id/contacts/some_email@some_provider.com/messages/an_id/body",
  "accounts/some_id/contacts/some_email@some_provider.com/messages/an_id/flags",
  "accounts/some_id/contacts/some_email@some_provider.com/messages/an_id/folders",
  "accounts/some_id/contacts/some_email@some_provider.com/messages/an_id/headers",
  "accounts/some_id/contacts/some_email@some_provider.com/messages/an_id/source",
  "accounts/some_id/contacts/some_email@some_provider.com/messages/an_id/thread"
]

ACCOUNT_REQUEST_COLLECTION_ENDPOINTS = [
  "accounts",
  "accounts/some_id/connect_tokens",
  "accounts/some_id/email_addresses",
  "accounts/some_id/files",
  "accounts/some_id/files/some_email@some_provider.com",
  "accounts/some_id/messages/some_email@some_provider.com"
]

CONTACT_COLLECTION_ENDPOINTS = ["accounts/some_id/contacts"]

#Some of these endpoints will have account in the URL. The purpose of these URLs
#is to ensure there is a different return for endpoints such as
# accounts/:id/files and account/:id/contacts/:email/files
NON_ACCOUNT_ENDPOINTS = [
  "connect_tokens/",
  "oauth_providers"
]

NON_JSON_ENDPOINTS = [
  "accounts/some_id/files/some_file/content"
]

CONTACTS_COLLECITION_ENDPOINTS = [
  "accounts/some_id/contacts/some_email@some_provider.com/files",
  "accounts/some_id/contacts/some_email@some_provider.com/messages",
  "accounts/some_id/contacts/some_email@some_provider.com/threads"
]

WebMock.disable_net_connect!(allow_localhost: true)
RSpec.configure do |config|
  config.before(:each) do
    ACCOUNT_REQUEST_ENDPOINTS.each do |endpoint|
      stub_request(:get, "https://api.context.io/2.0/#{endpoint}").
        with(headers: {'Accept'=>'*/*', "User-Agent" => "contextio-ruby-2.0"}).
        to_return(status: 200,
                  body: MockResponse::FROM_ACCOUNT_MOCK_FARADAY_SUCCESS_BODY,
                  headers: {"content-type" => "application/json"})
    end
    ACCOUNT_REQUEST_COLLECTION_ENDPOINTS.each do |endpoint|
      stub_request(:get, "https://api.context.io/2.0/#{endpoint}").
        with(headers: {'Accept'=>'*/*', "User-Agent" => "contextio-ruby-2.0"}).
        to_return(status: 200,
                  body: MockResponse::ACCOUNT_COLLECTION_FARADAY_SUCCESS_BODY,
                  headers: {"content-type" => "application/json"})
    end
    CONTACT_COLLECTION_ENDPOINTS.each do |endpoint|
      stub_request(:get, "https://api.context.io/2.0/#{endpoint}").
        with(headers: {'Accept'=>'*/*', "User-Agent" => "contextio-ruby-2.0"}).
        to_return(status: 200,
                  body: MockResponse::CONTACT_COLLECTION_FARADAY_SUCCESS_BODY,
                  headers: {"content-type" => "application/json"})
    end
    NON_ACCOUNT_ENDPOINTS.each do |endpoint|
      stub_request(:get, "https://api.context.io/2.0/#{endpoint}").
        with(headers: {'Accept'=>'*/*', "User-Agent" => "contextio-ruby-2.0"}).
        to_return(status: 200,
                  body: MockResponse::ACCOUNT_COLLECTION_FARADAY_SUCCESS_BODY,
                  headers: {"content-type" => "application/json"})
    end
    CONTACTS_COLLECITION_ENDPOINTS.each do |endpoint|
      stub_request(:get, "https://api.context.io/2.0/#{endpoint}").
        with(headers: {'Accept'=>'*/*', "User-Agent" => "contextio-ruby-2.0"}).
        to_return(status: 200,
                  body: MockResponse::NON_ACCOUNT_COLLECTION_FARADAY_SUCCESS_BODY,
                  headers: {"content-type" => "application/json"})
    end
    NON_JSON_ENDPOINTS.each do |endpoint|
      stub_request(:get, "https://api.context.io/2.0/#{endpoint}").
        with(headers: {'Accept'=>'*/*', "User-Agent" => "contextio-ruby-2.0"}).
        to_return(status: 200,
                  body: MockResponse::NON_ACCOUNT_COLLECTION_FARADAY_SUCCESS_BODY,
                  headers: {})
   end
  end
end
