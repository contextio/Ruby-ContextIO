require "contextio/connection"
require "contextio/account"

require_relative "../utilities/testing_constants.rb"
require_relative "../utilities/mock_response.rb"

FILES_ACCOUNTS_PATH = MockResponse::ACCOUNT_COLLECTION_FARADAY_SUCCESS_BODY
FILES_CONTACTS_PATH = MockResponse::NON_ACCOUNT_COLLECTION_FARADAY_SUCCESS_BODY

describe Files do
  describe "A Files object fetched from a Contacts object" do
    subject { MockResponse::MOCK_CONTACT.get_files }

    it "Response does not come from the Accounts object path." do
      expect(subject.response[1].response[1][0]).not_to eq(JSON.parse(FILES_ACCOUNTS_PATH)["matches"][0])
    end

    it "Response does come from the Contacts object path." do
      expect(subject.response[1].response[1][0]).to eq(JSON.parse(FILES_CONTACTS_PATH)["matches"][0])
    end

    it "Was successful" do
      expect(subject.success?).to be true
    end
  end

  describe "A Files object fetched from an Accounts object" do
    subject { MockResponse::MOCK_ACCOUNT.get_files }
    it "Response does not come from the Contacts object path." do
      expect(subject.response).not_to eq(JSON.parse(FILES_CONTACTS_PATH))
    end

    it "Response does not come from the Contacts object path." do
      expect(subject.response).to eq(JSON.parse(FILES_ACCOUNTS_PATH))
   end
  end
end
