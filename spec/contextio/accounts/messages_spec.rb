require "contextio/connection"
require "contextio/account"

require_relative "../utilities/testing_constants.rb"
require_relative "../utilities/mock_response.rb"


MESSAGES_ACCOUNTS_PATH = MockResponse::ACCOUNT_COLLECTION_FARADAY_SUCCESS_BODY
MESSAGES_CONTACTS_PATH = MockResponse::NON_ACCOUNT_COLLECTION_FARADAY_SUCCESS_BODY

describe Message do
  describe "A Messages object fetched from a Contacts object" do
    subject { MockResponse::MOCK_CONTACT.get_messages[0] }

    it "Response does not come from the Accounts object path." do
      expect(subject.addresses).not_to eq(JSON.parse(MESSAGES_ACCOUNTS_PATH)[0]["addresses"])
    end

    it "Response does come from the Contacts object path." do
      expect(subject.addresses).to eq(JSON.parse(MESSAGES_CONTACTS_PATH)[0]["addresses"])
    end

    it "Was successful" do
      expect(subject.success?).to be true
    end
  end
end
