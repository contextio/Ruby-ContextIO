require "contextio/connection"
require "contextio"

require_relative "../utilities/testing_constants.rb"

module ContextIO
  describe ConnectToken do
    describe "A ConnectToken object can be fetched" do
      subject { ConnectToken.new(parent: TestingConstants::MOCK_ACCOUNT.get,
                                 identifier: "a_token").get }

      it "Returns a 200 status." do
        expect(subject.status).to eq(200)
      end

      it "Was a successful API call." do
        expect(subject.success?).to be true
      end

      it "Has an API call made" do
        expect(subject.api_call_made).not_to be_nil
      end

      it "Created a ConnectTokens object" do
        expect(subject.class).to eq(ConnectToken)
        expect(subject.call_url).to eq("/2.0/accounts/some_id/connect_tokens/a_token")
      end

      it "Was Successful." do
        expect(subject.success?).to be true
      end
    end
  end
end
