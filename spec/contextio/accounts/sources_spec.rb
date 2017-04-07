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

      it "Has an API call made" do
        expect(subject.api_call_made).not_to be_nil
      end

      it "Can return a call URL" do
        expect(subject.call_url).to eq("/2.0/accounts/some_id/sources/0")
      end

      it "Can return a Folder" do
        expect(subject.get_folder(folder: "Hello").class.to_s).to eq("ContextIO::Folder")
      end

      it "Can return a collection of Folders" do
        expect(subject.get_folders[0].class.to_s).to eq("ContextIO::Folder")
        expect(subject.get_folders.count).to eq(2)
      end

      it "Can return a Sync" do
        expect(subject.sync.class.to_s).to eq("ContextIO::Sync")
      end

      it "Can return a single ConnectToken" do
        expect(subject.get_connect_token(token: "some_token").class.to_s).to eq("ContextIO::ConnectToken")
      end

      it "Can return a collection ConnectToken" do
        expect(subject.get_connect_tokens[0].class.to_s).to eq("ContextIO::ConnectToken")
        expect(subject.get_connect_tokens.count).to eq(2)
      end
    end
  end
end
