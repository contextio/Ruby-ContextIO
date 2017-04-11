require "context_io/connection"
require "context_io/account"

require_relative "../utilities/testing_constants.rb"
require_relative "../utilities/mock_response.rb"

module ContextIO
  describe Message do
    let(:messages_account_path)  { "/2.0/accounts/some_id/messages/12345" }
    let(:messages_contacts_path) { "/2.0/accounts/some_id/contacts/some_email%40some_provider.com/messages/an_id" }
    describe "A Messages object fetched from a Contacts object" do
      subject { TestingConstants::MOCK_CONTACT.get_messages[0] }

      it "Returns a 200 status." do
        expect(subject.status).to eq(200)
      end

      it "Was a successful API call." do
        expect(subject.success?).to be true
      end

      it "Has an API call made" do
        expect(subject.api_call_made).not_to be_nil
      end

      it "Has a call url" do
        expect(subject.call_url).to eq(messages_contacts_path)
      end

      it "Response does not come from the Accounts object path." do
        expect(subject.call_url).not_to eq(messages_account_path)
      end

      it "Response does come from the Contacts object path." do
        expect(subject.call_url).to eq(messages_contacts_path)
      end

      it "Can't update itself" do
        expect{ subject.post(dst_folder: "a_new_folder") }.to raise_error(StandardError,
                                                                          "This method can only be called from '2.0/accounts/:account/message/:message_id'")
      end

      it "Cannot return a body" do
        expect{ subject.get_body }.to raise_error(StandardError,
                                                  "This method can only be called from '2.0/accounts/:account/message/:message_id'")
      end

      it "Cannot return a flags" do
        expect{ subject.get_flags }.to raise_error(StandardError,
                                                   "This method can only be called from '2.0/accounts/:account/message/:message_id'")
      end

      it "Cannot return a folders" do
        expect{ subject.get_folders }.to raise_error(StandardError,
                                                     "This method can only be called from '2.0/accounts/:account/message/:message_id'")
      end

      it "Cannot return a headers" do
        expect{ subject.get_headers }.to raise_error(StandardError,
                                                     "This method can only be called from '2.0/accounts/:account/message/:message_id'")
      end

      it "Cannot return a source" do
        expect{ subject.get_source }.to raise_error(StandardError,
                                                    "This method can only be called from '2.0/accounts/:account/message/:message_id'")
      end

      it "Cannot return a threads" do
        expect{ subject.get_threads }.to raise_error(StandardError,
                                                     "This method can only be called from '2.0/accounts/:account/message/:message_id'")
      end
    end

    describe "A Messages object fetched from an Accounts object" do
      subject { TestingConstants::MOCK_ACCOUNT_MESSAGE.get }

      it "Response does not come from the Contacts object path." do
        expect(subject.call_url).not_to eq(messages_contacts_path)
      end

      it "Response does come from the Accounts object path." do
        expect(subject.call_url).to eq(messages_account_path)
      end

      it "Can update itself" do
        updated_message = subject.post(dst_folder: "a_new_folder")
        expect(updated_message.class).to eq(Message)
        expect(updated_message.call_url).to eq(messages_account_path)
      end

      it "Can return a body" do
        expect(subject.get_body.api_call_made.url.to_s).to eq("https://api.context.io#{messages_account_path}/body")
        expect(subject.get_body.success?).to be true
      end

      it "Can return a flags" do
        expect(subject.get_flags.api_call_made.url.to_s).to eq("https://api.context.io#{messages_account_path}/flags")
        expect(subject.get_flags.success?).to be true
      end

      it "Can update flags" do
        updated_flags = subject.post_flags(read: 1)
        expect(updated_flags.class).to eq(Message)
        expect(updated_flags.call_url).to eq(messages_account_path)
      end

      it "Can return a folders" do
        expect(subject.get_folders.api_call_made.url.to_s).to eq("https://api.context.io#{messages_account_path}/folders")
        expect(subject.get_folders.success?).to be true
      end

      it "Can return a headers" do
        expect(subject.get_headers.api_call_made.url.to_s).to eq("https://api.context.io#{messages_account_path}/headers")
        expect(subject.get_headers.success?).to be true
      end

      it "Can return a source" do
        expect(subject.get_source.api_call_made.url.to_s).to eq("https://api.context.io#{messages_account_path}/source")
        expect(subject.get_source.success?).to be true
      end

      it "Can return a threads" do
        expect(subject.get_threads.api_call_made.url.to_s).to eq("https://api.context.io#{messages_account_path}/thread")
        expect(subject.get_threads.success?).to be true
      end
    end
  end
end
