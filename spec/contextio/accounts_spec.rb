require_relative "./utilities/testing_constants.rb"

module ContextIO
  describe Account do
    describe "An Account object holding just one account." do
      subject { Account.new(parent: TestingConstants::CIO_2_POINT_0_OBJECT, identifier: "some_id").get }

      it "Returns a 200 status." do
        expect(subject.status).to eq(200)
      end

      it "Was a successful API call." do
        expect(subject.success?).to be true
      end

      it "Has an API call made" do
        expect(subject.api_call_made).not_to be_nil
      end

      it "Can be used to find ConnectTokens." do
        connect_token = subject.get_connect_tokens.first
        expect(connect_token.class).to eq(ConnectToken)
        expect(connect_token.call_url).to eq("/2.0/accounts/some_id/connect_tokens/a_token")
      end

      it "Can be used to find Contacts." do
        contact = subject.get_contacts[1].first
        expect(contact.class).to eq(Contact)
        expect(contact.call_url).to eq("/2.0/accounts/some_id/contacts/an_account_email_address")
      end

      it "Can be used to find EmailAdresses" do
        email = subject.get_email_addresses.first
        expect(email.class).to eq(EmailAddress)
        expect(email.call_url).to eq("/2.0/accounts/some_id/email_addresses/an_email")
      end

      it "Can be used to find Files" do
        files = subject.get_files.first
        expect(files.class).to eq(Files)
        expect(files.call_url).to eq("/2.0/accounts/some_id/files/an_id")
      end

      it "Can be used to find Messages" do
        message = subject.get_messages.first
        expect(message.class).to eq(Message)
        expect(message.call_url).to eq("/2.0/accounts/some_id/messages/")
      end

      it "Can be used to find Sources" do
        sources = subject.get_sources.first
        expect(sources.class).to eq(Sources)
        expect(sources.call_url).to eq("/2.0/accounts/some_id/sources/")
      end

      it "Can be used to find Sync" do
        sync = subject.get_sync
        expect(sync.class).to eq(Sync)
        expect(sync.call_url).to eq("/2.0/accounts/some_id/sync")
      end

      it "Can be used to find Threads" do
        threads = subject.get_threads
        expect(threads.class).to eq(Threads)
        expect(threads.call_url).to eq("/2.0/accounts/some_id/threads/")
      end

      it "Can be used to find Webhooks" do
        webhook = subject.get_webhooks.first
        expect(webhook.class).to eq(Webhook)
        expect(webhook.call_url).to eq("/2.0/accounts/some_id/webhooks/")
      end
    end
  end
end
