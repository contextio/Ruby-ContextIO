require "contextio/connection"
require "contextio"


require_relative "../utilities/testing_constants.rb"
require_relative "../utilities/mock_response.rb"
module ContextIO
  describe Contact do
    describe "A Contacts object created from an Account" do
      subject { MockResponse::MOCK_CONTACT }

      it "can get files" do
        expect(subject.get_files[0].class.to_s).to eq("Files")
      end

      it "can get threads" do
        expect(subject.get_threads.class.to_s).to eq("Threads")
      end

      it "can get messages" do
        expect(subject.get_messages[0].class.to_s).to eq("Message")
      end
    end
  end
end
