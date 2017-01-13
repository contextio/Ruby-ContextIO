require_relative "../utilities/testing_constants.rb"
require_relative "../utilities/mock_response.rb"

module ContextIO
  describe Folder do
    describe "A Folder from a Source" do
      subject { TestingConstants::MOCK_SOURCE_FOLDER.get }

      it "Returns a 200 status." do
        expect(subject.status).to eq(200)
      end

      it "Was a successful API call." do
        expect(subject.success?).to be true
      end

      it "Can return an encoded name" do
        expect(subject.encoded_name).to eq("%5BGmail%5D%2FSent%20Mail")
      end

      it "Can return a call URL" do
        expect(subject.call_url).to eq("2.0/accounts/some_id/source/0/folders/%5BGmail%5D%2FSent%20Mail")
      end

      it "can get messages" do
        expect(subject.messages[0].class.to_s).to eq("ContextIO::Message")
      end
    end
  end
end
