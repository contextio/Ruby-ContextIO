require_relative "../utilities/testing_constants.rb"
require_relative "../utilities/mock_response.rb"

module ContextIO
  describe Webhook do
    describe "A Webhook From an Account" do
      subject { TestingConstants::MOCK_WEBHOOK.get }

      it "Can be fetched" do
        expect(subject.status).to eq(200)
        expect(subject.success).to be(true)
      end
    end
  end
end
