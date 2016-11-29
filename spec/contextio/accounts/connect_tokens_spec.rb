require "contextio/connection"
require "contextio"

require_relative "../utilities/testing_constants.rb"

describe ConnectTokens do
  describe "A ConnectTokens object can be fetched" do
    subject { ConnectTokens.fetch(CONNECTION_BASE,
                                  "12345",
                                  "some_token_id") }

    it "Created a ConnectTokens object" do
      expect(subject.class.to_s).to eq("ConnectTokens")
    end

    it "Was Successful." do
      expect(subject.success?).to be true
    end
  end
end
