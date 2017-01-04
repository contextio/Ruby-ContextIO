require "contextio/connection"
require "contextio/account"

require_relative "../utilities/testing_constants.rb"
require_relative "../utilities/mock_response.rb"

module ContextIO
  describe Files do
    let(:files_accounts_path)  { "/2.0/accounts/some_id/files/some_file" }
    let(:files_contacts_path) { "2.0/accounts/some_id/contacts/some_email@some_provider.com/files/an_id" }
    describe "A Files object fetched from a Contacts object" do
      subject { TestingConstants::MOCK_CONTACT.get.get_files[0] }

      it "Returns a 200 status." do
        expect(subject.status).to eq(200)
      end

      it "Was a successful API call." do
        expect(subject.success?).to be true
      end

      it "Response does not come from the Accounts object path." do
        expect(subject.call_url).not_to eq(files_accounts_path)
      end

      it "Response does come from the Contacts object path." do
        expect(subject.call_url).to eq(files_contacts_path)
      end
    end

    describe "A Files object fetched from an Accounts object" do
      subject { Files.new(identifier: "some_file", parent: TestingConstants::MOCK_ACCOUNT).get }
       it "Response does not come from the Contacts object path." do
         expect(subject.call_url).not_to eq(files_contacts_path)
       end

       it "Response does come from the Acccounts object path." do
         expect(subject.call_url).to eq(files_accounts_path)
      end
      it "Can fetch content." do
        expect(subject.content.success?).to be true 
      end
    end
  end
end
