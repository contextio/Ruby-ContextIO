describe ContextIO do
  it "has a version number" do
    expect(ContextIO::VERSION).not_to be false
  end

  describe "a new 2.0 ContextIO object" do
    subject { ContextIO::ContextIO.new(key: "key", secret: "secret", version: "2.0") }

    it "needs arguments to for a ContextIO object" do
      expect{ ContextIO::ContextIO.new() }.to raise_error(ArgumentError)
    end

    it "has a connection on creation" do
      expect(subject.connection).not_to be nil
    end

    it "has a connection that is a Connection" do
      expect(subject.connection.class.to_s).to eq("ContextIO::Connection")
    end

    it "can return an Accounts object" do
      account = subject.get_accounts.first
      expect(account.class).to eq(ContextIO::Account)
      expect(account.call_url).to eq("/2.0/accounts/an_id")
    end

    it "can create an Accounts object" do
      account = subject.post_account
      expect(account.class).to eq(ContextIO::Account)
      expect(account.call_url).to eq("/2.0/accounts/some_id")
    end

    it "can return a ConnectToken object" do
      connect_token = subject.get_connect_tokens.first
      expect(connect_token.class).to eq(ContextIO::ConnectToken)
      expect(connect_token.call_url).to eq("/2.0/connect_tokens/a_token")
    end

    it "can create a ConnectToken object" do
      connect_token = subject.post_connect_token(callback_url: "www.example.com")
      expect(connect_token.class).to eq(ContextIO::ConnectToken)
      expect(connect_token.call_url).to eq("/2.0/connect_tokens/a_token")
    end

    it "can return a Discovery object" do
      discovery = subject.discovery(email: "some_email")
      expect(discovery.class).to eq(ContextIO::Discovery)
      expect(discovery.call_url).to eq("/2.0/discovery?email=some_email&source_type=IMAP")
    end

    it "can return a OauthProvider object" do
      oauth = subject.get_oauth_providers.first
      expect(oauth.class).to eq(ContextIO::OauthProvider)
      expect(oauth.call_url).to eq("/2.0/oauth_providers/a_key")
    end

    it "can create a OauthProvider object" do
      oauth = subject.post_oauth_provider(provider_consumer_key: "a key",
                                          provider_consumer_secret: "a secret",
                                          type: "a type")
      expect(oauth.class).to eq(ContextIO::OauthProvider)
      expect(oauth.call_url).to eq("/2.0/oauth_providers/a_key")
    end

    it "can return a Webhook object" do
      webhook = subject.get_webhooks.first
      expect(webhook.class).to eq(ContextIO::Webhook)
      expect(webhook.call_url).to eq("/2.0/webhooks/a_webhook_id")
    end

    it "can create a Webhook object" do
      webhook = subject.post_webhook(callback_url: "www.example.com")
      expect(webhook.class).to eq(ContextIO::Webhook)
      expect(webhook.call_url).to eq("/2.0/webhooks/a_webhook_id")
    end

    it "has a version of 2.0" do
      expect(subject.version).to eq("2.0")
    end

    it "has the proper call_url" do
      expect(subject.call_url).to eq("/2.0")
      expect(subject.call_url).not_to eq("/lite")
    end

    it "was non JSON" do
      expect{ subject.get_request(url: "non-json-failure") }.to raise_error(StandardError, "HTTP code 500. Response This is a failed request")
    end

    it "was JSON" do
      expect{ subject.get_request(url: "no-message-failure") }.to raise_error(StandardError, "HTTP code 500. No API error given.")
    end
  end
end
