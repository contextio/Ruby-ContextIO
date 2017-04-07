require_relative "../utilities/testing_constants.rb"
require_relative "../utilities/mock_response.rb"

module ContextIO
  describe Webhook do
    describe "A Webhook From an Account" do
      subject { TestingConstants::MOCK_ACCOUNT_WEBHOOK.get }

      it "Can be fetched" do
        expect(subject.status).to eq(200)
        expect(subject.success).to be(true)
      end

      it "Can update itself" do
        updated_webhook = subject.post(callback_url: "www.example.com")
        expect(updated_webhook.class).to eq(Webhook)
        expect(updated_webhook.call_url).to eq("/2.0/accounts/some_id/webhooks/a_webhook_id")
      end

      it "Has an API call made" do
        expect(subject.api_call_made).not_to be_nil
      end
    end

    describe "A Webhook For an Developer Key" do
      subject { TestingConstants::MOCK_WEBHOOK.get }

      it "Can be fetched" do
        expect(subject.status).to eq(200)
        expect(subject.success).to be(true)
      end

      it "Can update itself" do
        updated_webhook = subject.post(callback_url: "www.example.com")
        expect(updated_webhook.class).to eq(Webhook)
        expect(updated_webhook.call_url).to eq("/2.0/webhooks/a_webhook_id")
      end

      it "Has an API call made" do
        expect(subject.api_call_made).not_to be_nil
      end
    end
  end
end
