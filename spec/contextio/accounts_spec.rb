require "contextio/accounts"
require_relative "./mock_response.rb"

RESPONSE = MockResponse::ACCOUNTS

describe Accounts do
  describe "An Accounts object holding more than one account" do
    subject { Accounts.new(RESPONSE, "secret") }

    it "Returns an onject with an error if a method is called on it" do
      expect(subject.connect_tokens.success?).to be false
    end
  end

end
