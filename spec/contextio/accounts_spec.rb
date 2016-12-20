require "contextio/connection"
require "contextio/account"
require "contextio/account/connect_token"
require "contextio/account/contact"

require_relative "./utilities/mock_response.rb"
require_relative "./utilities/testing_constants.rb"

RESPONSE = MockResponse::ACCOUNTS
#TODO: One assertion for object responses
describe Account do
  describe "An Accounts object holding more than one account" do
    subject { CIO_OBJECT.get_accounts }

    it "Returns an onject with an error if a method is called on it" do
      expect(subject.connect_token.success?).to be false
    end
  end

  describe "An Accounts object holding just one account." do
    subject { Account.new(context_io: CIO_OBJECT, identifier: "some_id").get }

    it "Returns a 200 status." do
      expect(subject.status).to eq(200)
    end

    it "Was a successful API call." do
      expect(subject.success?).to be true
    end

    it "Can be used to find ConnectTokens." do
      expect(subject.get_connect_tokens[0].class.to_s).to eq("ConnectToken")
    end

    it "Can be used to find Contacts." do
      expect(subject.get_contacts[0].class.to_s).to eq("Contact")
    end
  end
end
