describe ContextIO do
  it "has a version number" do
    expect(ContextIO::VERSION).not_to be false
  end

  describe "new 2.0 ContextIO object" do
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
      expect(subject.get_accounts[0].class.to_s).to eq("ContextIO::Account")
    end

    it "can return an ConnectToken object" do
      expect(subject.get_connect_tokens[0].class.to_s).to eq("ContextIO::ConnectToken")
    end

    it "can return an Discovery object" do
      expect(subject.discovery(email: "some_email").class.to_s).to eq("ContextIO::Discovery")
    end

    it "can return an OauthProvider object" do
      expect(subject.get_oauth_providers[0].class.to_s).to eq("ContextIO::OauthProvider")
    end

    it "can return an Webhook object" do
      expect(subject.get_webhooks[0].class.to_s).to eq("ContextIO::Webhook")
    end

    it "has a version of 2.0" do
      expect(subject.version).to eq("2.0")
    end

    it "has the proper call_url" do
      expect(subject.call_url).to eq("/2.0")
      expect(subject.call_url).not_to eq("/lite")
    end

    it "can return a collection of objects" do
      request = MockResponse::MOCK_FARDAY_COLLECTION
      responses = subject.collection_return(request, subject, ContextIO::Account)
      expect(responses.count).to eq(2)
      expect(responses.first.class.to_s).to eq("ContextIO::Account")
    end
  end
end
