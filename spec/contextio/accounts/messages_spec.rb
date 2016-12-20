require "contextio/connection"
require "contextio/account"

require_relative "../utilities/testing_constants.rb"
require_relative "../utilities/mock_response.rb"


MESSAGES_ACCOUNTS_PATH = MockResponse::FROM_ACCOUNT_MOCK_FARADAY_SUCCESS_BODY
MESSAGES_CONTACTS_PATH = MockResponse::MOCK_FARADAY_SUCCESS_BODY

describe Message do
  describe "A Messages object fetched from a Contacts object" do
    subject { MockResponse::MOCK_CONTACT.get_messages }

    it "Response does not come from the Accounts object path." do
      expect(subject.response[0].response).not_to eq(JSON.parse(ACCOUNT_COLLECTION_FARADAY_SUCCESS_BODY)[0])
    end

    it "Response does come from the Contacts object path." do
      expect(subject.response[0].response).to eq(JSON.parse(NON_ACCOUNT_COLLECTION_FARADAY_SUCCESS_BODY)[0])
    end

    it "Was successful" do
      expect(subject.success?).to be true
    end
  end
end
