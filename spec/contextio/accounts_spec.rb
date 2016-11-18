require_relative "./mock_response.rb"

require "contextio/connection"
require "contextio/accounts"
require "contextio/accounts/connect_tokens"
require "contextio/accounts/contacts"

RESPONSE = MockResponse::ACCOUNTS

describe Accounts do
  describe "An Accounts object holding more than one account" do
    subject { Accounts.new(RESPONSE, "raw_response_body", "200") }

    it "Returns an onject with an error if a method is called on it" do
      expect(subject.connect_tokens.success?).to be false
    end
  end

  describe "An Accounts object holding just one account." do
    subject { Accounts.fetch(Connection.new("key", "secret"), "some_id") }

    it "Returns a 200 status." do
      expect(subject.status).to eq("200")
    end

    it "Was a successful API call." do
      expect(subject.success?).to eq(true)
    end

    it "Can be used to find ConnectTokens." do
      expect(subject.connect_tokens.class.to_s).to eq("ConnectTokens")
    end

    it "Can be used to find Contacts." do
      expect(subject.contacts.class.to_s).to eq("Contacts")
    end

    it "Can be used to find EmailAddresses." do
      expect(subject.email_addresses.class.to_s).to eq("EmailAddresses")
    end

    it "Can be used to find Files." do
      expect(subject.files.class.to_s).to eq("Files")
    end

    it "Can be used to find Messages." do
      expect(subject.messages.class.to_s).to eq("Messages")
    end

    it "Can be used to find Sources." do
      expect(subject.sources.class.to_s).to eq("Sources")
    end

    it "Can be used to find Sync." do
      expect(subject.sync.class.to_s).to eq("Sync")
    end

    it "Can be used to find Threads." do
      expect(subject.threads.class.to_s).to eq("Threads")
    end

    it "Can be used to find WebHooks." do
      expect(subject.webhooks.class.to_s).to eq("Webhooks")
    end
  end
end
