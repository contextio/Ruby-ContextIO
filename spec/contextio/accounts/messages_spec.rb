require "contextio/connection"
require "contextio/accounts"

require_relative "../utilities/testing_constants.rb"
require_relative "../utilities/mock_response.rb"


MESSAGES_ACCOUNTS_PATH = MockResponse::FROM_ACCOUNT_MOCK_FARADAY_SUCCESS_BODY
MESSAGES_CONTACTS_PATH = MockResponse::MOCK_FARADAY_SUCCESS_BODY

describe Messages do
  describe "A Messages object fetched from a Contacts object" do
    subject { MockResponse::MOCK_CONTACT.messages(MOCK_EMAIL) }

    it "Response does not come from the Accounts object path." do
      expect(subject.response).not_to eq(JSON.parse(MESSAGES_ACCOUNTS_PATH))
    end

    it "Response does come from the Contacts object path." do
      expect(subject.response).to eq(JSON.parse(MESSAGES_CONTACTS_PATH))
    end

    it "Was successful" do
      expect(subject.success?).to be true
    end
  end
end
