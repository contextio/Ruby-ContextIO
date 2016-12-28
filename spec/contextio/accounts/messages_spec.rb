require "contextio/connection"
require "contextio/account"

require_relative "../utilities/testing_constants.rb"
require_relative "../utilities/mock_response.rb"

module ContextIO
  describe Message do
    let(:messages_account_path)  { MockResponse::ACCOUNT_COLLECTION_FARADAY_SUCCESS_BODY }
    let(:messages_contacts_path) { MockResponse::NON_ACCOUNT_COLLECTION_FARADAY_SUCCESS_BODY }
    describe "A Messages object fetched from a Contacts object" do
      subject { MockResponse::MOCK_CONTACT.get_messages[0] }

      it "Response does not come from the Accounts object path." do
        expect(subject.addresses).not_to eq(JSON.parse(messages_account_path)[0]["addresses"])
      end

      it "Response does come from the Contacts object path." do
        expect(subject.addresses).to eq(JSON.parse(messages_contacts_path)[0]["addresses"])
      end

      it "Was successful" do
        expect(subject.success?).to be true
      end
    end
  end
end
