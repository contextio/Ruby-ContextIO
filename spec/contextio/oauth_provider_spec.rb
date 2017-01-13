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

      it "Has a call URL" do
        expect(subject.call_url).to eq("/2.0/oauth_providers/some_key")
      end
  end
end
