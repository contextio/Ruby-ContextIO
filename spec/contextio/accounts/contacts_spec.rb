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
        expect(subject.get_files[0].class.to_s).to eq("ContextIO::Files")
      end

      it "can get threads" do
        expect(subject.get_threads.class.to_s).to eq("ContextIO::Threads")
      end

      it "can get messages" do
        expect(subject.get_messages[0].class.to_s).to eq("ContextIO::Message")
      end
    end
  end
end
