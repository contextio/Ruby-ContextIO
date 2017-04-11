require "context_io/connection"
require "context_io/account"

require_relative "../utilities/testing_constants.rb"
require_relative "../utilities/mock_response.rb"

module ContextIO
  describe Files do
    let(:files_accounts_path)  { "/2.0/accounts/some_id/files/some_file" }
    let(:files_contacts_path) { "/2.0/accounts/some_id/contacts/some_email%40some_provider.com/files/an_id" }
    describe "A Files object fetched from a Contacts object" do
      subject { TestingConstants::MOCK_CONTACT.get.get_files[0] }

      it "Returns a 200 status." do
        expect(subject.status).to eq(200)
      end

      it "Was a successful API call." do
        expect(subject.success?).to be true
      end

      it "Has an API call made" do
        expect(subject.api_call_made).not_to be_nil
      end

      it "Response does not come from the Accounts object path." do
        expect(subject.call_url).not_to eq(files_accounts_path)
      end

      it "Response does come from the Contacts object path." do
        expect(subject.call_url).to eq(files_contacts_path)
      end

      it "Cannot call non-contact methods" do
        expect{ subject.get_content }.to raise_error(StandardError,
                                                 "This method can only be called from '2.0/accounts/:account/file/:file_id'")
        expect{ subject.get_related }.to raise_error(StandardError,
                                                 "This method can only be called from '2.0/accounts/:account/file/:file_id'")
      end
    end

    describe "A Files object fetched from an Accounts object" do
      subject { TestingConstants::MOCK_ACCOUNT_FILE.get }
       it "Response does not come from the Contacts object path." do
         expect(subject.call_url).not_to eq(files_contacts_path)
       end

       it "Response does come from the Acccounts object path." do
         expect(subject.call_url).to eq(files_accounts_path)
      end

      it "Can fetch content." do
        content_file = subject.get_content
        expect(content_file.class).to eq(Files)
      end

      it "Can fetch content with optional paramters" do
        content_file = subject.get_content(as_link: 1)
        expect(content_file.class).to eq(Files)
        expect(content_file.api_call_made.url.to_s).to eq("https://api.context.io/2.0/accounts/some_id/files/some_file/content?as_link=1")
      end

      it "Can fetch content." do
        content_file = subject.get_content(bad_param: "bad_param")
        expect(content_file.class).to eq(Files)
        expect(content_file.api_call_made.url.to_s).to eq("https://api.context.io/2.0/accounts/some_id/files/some_file/content")
        expect(content_file.api_call_made.rejected_params).to eq([:bad_param])
      end

      it "Can fetch related files." do
        expect(subject.get_related.success?).to be true
      end
    end
  end
end
