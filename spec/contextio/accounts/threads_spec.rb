require_relative "../utilities/testing_constants.rb"
require_relative "../utilities/mock_response.rb"

module ContextIO
  describe Threads do
    describe "A Threads From an Account" do
      subject { TestingConstants::MOCK_THREADS.get }

      it "Can be fetched" do
        expect(subject.status).to eq(200)
        expect(subject.success).to be(true)
      end

      it "Has an API call made" do
        expect(subject).to respond_to(:api_call_made)
        expect(subject.api_call_made).not_to be_nil
      end

      it "Has Valid Get Paramaters" do
        expect(subject.valid_params).not_to be_nil
      end
    end
  end
end
