require 'simplecov'
SimpleCov.start

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "context_io"
require "webmock/rspec"

require_relative "./contextio/utilities/mock_response.rb"

ACCOUNT_REQUEST_ENDPOINTS = [
  "accounts/some_id",
  "accounts/some_id/connect_tokens/a_token",
  "accounts/some_id/contacts/some_email@some_provider.com",
  "accounts/some_id/email_addresses/some_email@some_provider.com",
  "accounts/some_id/messages",
  "accounts/some_id/messages/some_email@some_provider.com",
  "accounts/some_id/messages/12345",
  "accounts/some_id/messages/12345/body",
  "accounts/some_id/messages/12345/flags",
  "accounts/some_id/messages/12345/folders",
  "accounts/some_id/messages/12345/headers",
  "accounts/some_id/messages/12345/source",
  "accounts/some_id/messages/12345/thread",
  "accounts/some_id/sources",
  "accounts/some_id/sync",
  "accounts/some_id/threads",
  "accounts/some_id/webhooks",
  "accounts/some_id/files/some_file",
  "accounts/some_id/files/some_file/related",
  "accounts/some_id/files/some_file/content?as_link=1",
  "accounts/some_id/sources/0",
  "accounts/some_id/sources/a_new_source",
  "accounts/some_id/sources/0/folders/Hello",
  "accounts/some_id/sources/0/folders/%5BGmail%5D%2FSent%20Mail",
  "accounts/some_id/sources/0/sync",
  "accounts/some_id/sources/0/connect_tokens/some_token",
  "accounts/some_id/webhooks/a_webhook_id",
  "accounts/some_id/threads/some_thread"
]

ACCOUNT_REQUEST_COLLECTION_ENDPOINTS = [
  "accounts",
  "accounts/some_id/connect_tokens",
  "accounts/some_id/email_addresses",
  "accounts/some_id/files",
  "accounts/some_id/files/some_email@some_provider.com",
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
  "connect_tokens/a_token",
  "oauth_providers/a_key",
  "webhooks/a_webhook_id",
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

DELETE_ENDPOINT_TEST = [
  "accounts/some_id"
]

NEW_OBJECT_POST_REQUESTS = {
  accounts:                                { id: "some_id" },
  connect_tokens:                          { token: "a_token" },
  oauth_provider:                          { key: "a_key" },
  webhooks:                                { webhook_id: "a_webhook_id" },
  "accounts/some_id/connect_tokens":       { token: "a_token" },
  "accounts/some_id/email_addresses":      { email: "some_email@some_provider.com" },
  "accounts/some_id/sources":              { label: "a_new_source" },
  "accounts/some_id/webhooks":             { webhook_id: "a_webhook_id" },
  "accounts/some_id/messages/12345/flags": { message_id: "12345" }
}

UPDATED_OBJECT_POST_REQUESTS = [
  "webhooks/a_webhook_id",
  "accounts/some_id",
  "accounts/some_id/messages/12345",
  "accounts/some_id/webhooks/a_webhook_id",
  "accounts/some_id/sources/0"
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
    DELETE_ENDPOINT_TEST.each do |endpoint|
      stub_request(:delete, "https://api.context.io/2.0/#{endpoint}").
        with(headers: {'Accept'=>'*/*', "User-Agent" => "contextio-ruby-2.0"}).
        to_return(status: 200,
                  body: "{'success'=>true}",
                  headers: {})
     end
     NEW_OBJECT_POST_REQUESTS.each do |endpoint, identifier|
       stub_request(:post, "https://api.context.io/2.0/#{endpoint}").
         with(headers: {'Accept'=>'*/*', "User-Agent" => "contextio-ruby-2.0"}).
         to_return(status: 200,
                   body: JSON.generate(identifier.merge(success: true)),
                   headers: {"content-type" => "application/json"})
      end
      UPDATED_OBJECT_POST_REQUESTS.each do |endpoint|
        stub_request(:post, "https://api.context.io/2.0/#{endpoint}").
          with(headers: {'Accept'=>'*/*', "User-Agent" => "contextio-ruby-2.0"}).
          to_return(status: 200,
                    body: JSON.generate({ success: true }),
                    headers: {"content-type" => "application/json"})
       end
  end
end
