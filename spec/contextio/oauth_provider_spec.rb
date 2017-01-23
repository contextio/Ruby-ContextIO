module ContextIO
  describe OauthProvider do
      describe "An OauthProviderObject"
      subject { TestingConstants::MOCK_OAUTH_PROVIDER.get }

      it "Returns a 200 status." do
        expect(subject.status).to eq(200)
      end

      it "Was a successful API call." do
        expect(subject.success?).to be true
      end

      it "Has an API call made" do
        expect(subject).to respond_to(:api_call_made)
        expect(subject.api_call_made).not_to be_nil
      end

      it "Has a call URL" do
        expect(subject.call_url).to eq("/2.0/oauth_providers/some_key")
      end
  end
end
