require "contextio/connection"
require "contextio/accounts"

require_relative "../utilities/testing_constants.rb"
require_relative "../utilities/mock_response.rb"

ACCOUNTS_PATH = MockResponse::FROM_ACCOUNT_MOCK_FARADAY_OBJECT_SUCCESS_BODY
CONTACTS_PATH = MockResponse::MOCK_FARADAY_OBJECT_SUCCESS_BODY

describe Files do
  describe "A Files object fetched from a Contacts object" do
    subject { Files.contacts_fetch(CONNECTION_BASE,
                                   "12345",
                                   MOCK_EMAIL,
                                   :get) }

    it "Response does not come from the Accounts object path." do
      expect(subject.raw_response).not_to eq(ACCOUNTS_PATH)
    end

    it "Response does come from the Contacts object path." do
      expect(subject.raw_response).to eq(CONTACTS_PATH)
    end

    it "Was successful" do
      expect(subject.success?).to be true
    end
  end

  describe "A Files object fetched from an Accounts object" do
    subject { Files.fetch(CONNECTION_BASE,
                          "12345",
                          MOCK_EMAIL,
                          :get) }
    it "Response does not come from the Contacts object path." do
      expect(subject.raw_response).not_to eq(CONTACTS_PATH)
    end

    it "Response does not come from the Contacts object path." do
      expect(subject.raw_response).to eq(ACCOUNTS_PATH)
   end
  end

  describe "Determine API endpoint returns the proper URL" do
    it "Returns a Contacts URL when from_a_contact is true" do
      expect(Files.determine_api_endpoint("12345",
                                          "email",
                                          "contacts",
                                          true)).to eq("/2.0/accounts/12345/contacts/email/files")
    end

    it "Returns an Accounts and Email URL when given an email" do
      expect(Files.determine_api_endpoint("12345",
                                          "email",
                                          "files")).to eq("/2.0/accounts/12345/files/email")
    end

    it "Returns an Accounts and Email URL when given an email" do
      expect(Files.determine_api_endpoint("12345",
                                          nil,
                                          "files")).to eq("/2.0/accounts/12345/files")
    end
  end
end