require "contextio/connection"
require "contextio/account"

require_relative "../utilities/testing_constants.rb"
require_relative "../utilities/mock_response.rb"

module ContextIO
  describe Message do
    let(:messages_account_path)  { "/2.0/accounts/some_id/message/some_id" }
    let(:messages_contacts_path) { "2.0/accounts/some_id/contacts/some_email%40some_provider.com/messages/an_id" }
    describe "A Messages object fetched from a Contacts object" do
      subject { TestingConstants::MOCK_CONTACT.get_messages[0] }

      it "Returns a 200 status." do
        expect(subject.status).to eq(200)
      end

      it "Was a successful API call." do
        expect(subject.success?).to be true
      end

      it "Response does not come from the Accounts object path." do
        expect(subject.call_url).not_to eq(messages_account_path)
      end

      it "Response does come from the Contacts object path." do
        expect(subject.call_url).to eq(messages_contacts_path)
      end

      it "Can return a body" do
        expect(subject.body.success?).to be true
      end

      it "Can return a flags" do
        expect(subject.flags.success?).to be true
      end

      it "Can return a folders" do
        expect(subject.folders.success?).to be true
      end

      it "Can return a headers" do
        expect(subject.headers.success?).to be true
      end

      it "Can return a source" do
        expect(subject.source.success?).to be true
      end

      it "Can return a threads" do
        expect(subject.threads.success?).to be true
      end
    end
  end
end
