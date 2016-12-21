require "contextio/connection"
require "contextio"

require_relative "../utilities/testing_constants.rb"

describe ConnectToken do
  describe "A ConnectToken object can be fetched" do
    subject { ConnectToken.new(context_io: CIO_OBJECT,
                               account_id: "some_id",
                               identifier: "some_token_id").get }

    it "Created a ConnectTokens object" do
      expect(subject.class.to_s).to eq("ConnectToken")
    end

    it "Was Successful." do
      expect(subject.success?).to be true
    end
  end
end
