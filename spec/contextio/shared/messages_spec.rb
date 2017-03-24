require "contextio/connection"
require "contextio/account"

require_relative "../utilities/testing_constants.rb"
require_relative "../utilities/mock_response.rb"

module ContextIO
  describe Message do
    let(:messages_account_path)  { "2.0/accounts/some_id/messages/12345" }
    let(:messages_contacts_path) { "2.0/accounts/some_id/contacts/some_email%40some_provider.com/messages/an_id" }
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

      it "Can return a body" do
        expect(subject.body.api_call_made.url.to_s).to eq("https://api.context.io/#{messages_contacts_path}/body")
        expect(subject.body.success?).to be true
      end

      it "Can return a flags" do
        expect(subject.flags.api_call_made.url.to_s).to eq("https://api.context.io/#{messages_contacts_path}/flags")
        expect(subject.flags.success?).to be true
      end

      it "Can return a folders" do
        expect(subject.folders.api_call_made.url.to_s).to eq("https://api.context.io/#{messages_contacts_path}/folders")
        expect(subject.folders.success?).to be true
      end

      it "Can return a headers" do
        expect(subject.headers.api_call_made.url.to_s).to eq("https://api.context.io/#{messages_contacts_path}/headers")
        expect(subject.headers.success?).to be true
      end

      it "Can return a source" do
        expect(subject.source.api_call_made.url.to_s).to eq("https://api.context.io/#{messages_contacts_path}/source")
        expect(subject.source.success?).to be true
      end

      it "Can return a threads" do
        expect(subject.threads.api_call_made.url.to_s).to eq("https://api.context.io/#{messages_contacts_path}/thread")
        expect(subject.threads.success?).to be true
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
    end
  end
end
