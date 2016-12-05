require "contextio/connection"
require "contextio/accounts"

require_relative "../utilities/testing_constants.rb"
require_relative "../utilities/mock_response.rb"

ACCOUNTS_PATH = MockResponse::FROM_ACCOUNT_MOCK_FARADAY_SUCCESS_BODY
CONTACTS_PATH = MockResponse::MOCK_FARADAY_SUCCESS_BODY

describe Files do
  describe "A Files object fetched from a Contacts object" do
    subject { Files.contacts_fetch(CONNECTION_BASE,
                                   "some_id",
                                   MOCK_EMAIL,
                                   :get) }

    it "Response does not come from the Accounts object path." do
      expect(subject.response).not_to eq(JSON.parse(ACCOUNTS_PATH))
    end

    it "Response does come from the Contacts object path." do
      expect(subject.response).to eq(JSON.parse(CONTACTS_PATH))
    end

    it "Was successful" do
      expect(subject.success?).to be true
    end
  end

  describe "A Files object fetched from an Accounts object" do
    subject { Files.fetch(CONNECTION_BASE,
                          "some_id",
                          MOCK_EMAIL,
                          :get) }
    it "Response does not come from the Contacts object path." do
      expect(subject.response).not_to eq(JSON.parse(CONTACTS_PATH))
    end

    it "Response does not come from the Contacts object path." do
      expect(subject.response).to eq(JSON.parse(ACCOUNTS_PATH))
   end
  end
end
