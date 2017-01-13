require_relative "../utilities/testing_constants.rb"
require_relative "../utilities/mock_response.rb"

module ContextIO
  describe Sources do
    describe "A Source From an Account" do
      subject { TestingConstants::MOCK_SOURCE.get }

      it "Returns a 200 status." do
        expect(subject.status).to eq(200)
      end

      it "Was a successful API call." do
        expect(subject.success?).to be true
      end

      it "Can return a call URL" do
        expect(subject.call_url).to eq("2.0/accounts/some_id/sources/0")
      end

      it "Can return a folder" do
        expect(subject.folders(folder: "Hello").class.to_s).to eq("ContextIO::Folder")
      end

      it "Can return a collection of Folders" do
        expect(subject.folders[0].class.to_s).to eq("ContextIO::Folder")
        expect(subject.folders.count).to eq(2)
      end
    end
  end
end
