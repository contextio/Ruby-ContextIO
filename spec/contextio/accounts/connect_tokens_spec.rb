require "contextio/connection"
require "contextio"

require_relative "../utilities/testing_constants.rb"

module ContextIO
  describe ConnectToken do
    describe "A ConnectToken object can be fetched" do
      subject { ConnectToken.new(parent: TestingConstants::MOCK_ACCOUNT,
                                 identifier: "some_token_id").get }

      it "Returns a 200 status." do
        expect(subject.status).to eq(200)
      end

      it "Was a successful API call." do
        expect(subject.success?).to be true
      end

      it "Created a ConnectTokens object" do
        expect(subject.class.to_s).to eq("ContextIO::ConnectToken")
      end

      it "Was Successful." do
        expect(subject.success?).to be true
      end
    end
  end
end
