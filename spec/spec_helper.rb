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
  "accounts/some_id/contacts/some_email@some_provider.com/messages/an_id/thread",
  "accounts/some_id/sources/0",
  "accounts/some_id/sources/0/folders/Hello",
  "accounts/some_id/sources/0/folders/%5BGmail%5D%2FSent%20Mail",
  "accounts/some_id/sources/0/sync",
  "accounts/some_id/sources/0/connect_tokens/some_token",
  "accounts/some_id/webhooks/some_webhook",
  "accounts/some_id/threads/some_thread"
]

ACCOUNT_REQUEST_COLLECTION_ENDPOINTS = [
  "accounts",
  "accounts/some_id/connect_tokens",
  "accounts/some_id/email_addresses",
  "accounts/some_id/files",
  "accounts/some_id/files/some_email@some_provider.com",
  "accounts/some_id/messages/some_email@some_provider.com",
  "accounts/some_id/sources/0/folders",
  "accounts/some_id/sources/0/folders/%5BGmail%5D%2FSent%20Mail/messages",
  "accounts/some_id/sources/0/connect_tokens"
]

CONTACT_COLLECTION_ENDPOINTS = ["accounts/some_id/contacts"]

#Some of these endpoints will have account in the URL. The purpose of these URLs
#is to ensure there is a different return for endpoints such as
# accounts/:id/files and account/:id/contacts/:email/files
NON_ACCOUNT_COLLECTION_ENDPOINTS = [
  "connect_tokens",
  "webhooks",
  "oauth_providers"
]

NON_ACCOUNT_ENDPOINTS = [
  "oauth_providers/some_key",
  "discovery?email=some_email&source_type=IMAP"
]

NON_JSON_ENDPOINTS = [
  "accounts/some_id/files/some_file/content"
]

CONTACTS_COLLECITION_ENDPOINTS = [
  "accounts/some_id/contacts/some_email@some_provider.com/files",
  "accounts/some_id/contacts/some_email@some_provider.com/messages",
  "accounts/some_id/contacts/some_email@some_provider.com/threads"
]

NO_MESSAGE_FAILURE = [
  "no-message-failure"
]

NON_JSON_FAILURE = [
  "non-json-failure"
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
                  body: MockResponse::FROM_ACCOUNT_MOCK_FARADAY_SUCCESS_BODY,
                  headers: {"content-type" => "application/json"})
    end
    NON_ACCOUNT_COLLECTION_ENDPOINTS.each do |endpoint|
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
   NO_MESSAGE_FAILURE.each do |endpoint|
     stub_request(:get, "https://api.context.io/#{endpoint}").
       with(headers: {'Accept'=>'*/*', "User-Agent" => "contextio-ruby-2.0"}).
       to_return(status: 500,
                 body: "[]",
                 headers: {"content-type" => "application/json"})
   end
   NON_JSON_FAILURE.each do |endpoint|
     stub_request(:get, "https://api.context.io/#{endpoint}").
       with(headers: {'Accept'=>'*/*', "User-Agent" => "contextio-ruby-2.0"}).
       to_return(status: 500,
                 body: "This is a failed request",
                 headers: {})
    end
  end
end
