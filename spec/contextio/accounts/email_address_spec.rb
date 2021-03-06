require "context_io/connection"
require "context_io"

require_relative "../utilities/testing_constants.rb"

module ContextIO
  describe EmailAddress do
    describe "An EmailAddress" do
      subject { EmailAddress.new(identifier: "some_email@some_provider.com",
                                 parent: TestingConstants::MOCK_ACCOUNT).get }

      it "Returns a 200 status." do
        expect(subject.status).to eq(200)
      end

      it "Was a successful API call." do
        expect(subject.success?).to be true
      end

      it "Has an API call made" do
        expect(subject.api_call_made).not_to be_nil
      end
    end
  end
end
