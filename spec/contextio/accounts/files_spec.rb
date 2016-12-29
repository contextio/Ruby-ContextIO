require "contextio/connection"
require "contextio/account"

require_relative "../utilities/testing_constants.rb"
require_relative "../utilities/mock_response.rb"

module ContextIO
  FILES_ACCOUNTS_PATH = MockResponse::ACCOUNT_COLLECTION_FARADAY_SUCCESS_BODY
  FILES_CONTACTS_PATH = MockResponse::NON_ACCOUNT_COLLECTION_FARADAY_SUCCESS_BODY
  describe Files do
    let(:files_accounts_path)  { MockResponse::ACCOUNT_COLLECTION_FARADAY_SUCCESS_BODY }
    let(:files_contacts_path) { MockResponse::NON_ACCOUNT_COLLECTION_FARADAY_SUCCESS_BODY }
    describe "A Files object fetched from a Contacts object" do
      subject { TestingConstants::MOCK_CONTACT.get_files[0] }

      it "Response does not come from the Accounts object path." do
        expect(subject.addresses).not_to eq(JSON.parse(files_accounts_path)[0]["addresses"])
      end

      it "Response does come from the Contacts object path." do
        expect(subject.addresses).to eq(JSON.parse(files_contacts_path)[0]["addresses"])
      end

      it "Was successful" do
        expect(subject.success?).to be true
      end
    end

    # describe "A Files object fetched from an Accounts object" do
    #   subject { Files.new(account_id: "some_id", identifier: "some_file", parent: CIO_2_POINT_0_OBJECT).get }
    #   it "Response does not come from the Contacts object path." do
    #     expect(subject.email_addresses).not_to eq(JSON.parse(FILES_CONTACTS_PATH)[0]["addresses"])
    #   end
    #
    #   it "Response does not come from the Contacts object path." do
    #     expect(subject.email_addresses).to eq(JSON.parse(FILES_ACCOUNTS_PATH)[0]["addresses"])
    #  end
    # end
  end
end
