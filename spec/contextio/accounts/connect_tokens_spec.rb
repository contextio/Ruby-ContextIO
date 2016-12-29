require "contextio/connection"
require "contextio"

require_relative "../utilities/testing_constants.rb"

module ContextIO
  describe ConnectToken do
    describe "A ConnectToken object can be fetched" do
      subject { ConnectToken.new(parent: TestingConstants::MOCK_ACCOUNT,
                                 account_id: "some_id",
                                 identifier: "some_token_id").get }

      it "Created a ConnectTokens object" do
        expect(subject.class.to_s).to eq("ContextIO::ConnectToken")
      end

      it "Was Successful." do
        expect(subject.success?).to be true
      end
    end
  end
end
