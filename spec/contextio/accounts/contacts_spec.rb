require "contextio/connection"
require "contextio"

require_relative "../utilities/testing_constants.rb"
require_relative "../utilities/mock_response.rb"
module ContextIO
  describe Contact do
    describe "A Contacts object created from an Account" do
      subject { TestingConstants::MOCK_CONTACT.get }

      it "Returns a 200 status." do
        expect(subject.status).to eq(200)
      end

      it "Was a successful API call." do
        expect(subject.success?).to be true
      end

      it "Has an API call made" do
        expect(subject.api_call_made).not_to be_nil
      end

      it "can get files" do
        files = subject.get_files.first
        expect(files.class).to eq(Files)
        expect(files.call_url).to eq("2.0/accounts/some_id/contacts/some_email%40some_provider.com/files/an_id")
      end

      it "can get threads" do
        threads = subject.get_threads
        expect(threads.class).to eq(Threads)
        expect(threads.call_url).to eq("2.0/accounts/some_id/contacts/some_email%40some_provider.com/threads/")
      end

      it "can get messages" do
        messages = subject.get_messages.first
        expect(messages.class).to eq(Message)
        expect(messages.call_url).to eq("2.0/accounts/some_id/contacts/some_email%40some_provider.com/messages/an_id")
      end
    end
  end
end
