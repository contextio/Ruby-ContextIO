require "contextio/connection"
require "contextio/account"
require "contextio/account/connect_token"
require "contextio/account/contact"

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

      it "Can be used to find ConnectTokens." do
        expect(subject.get_connect_tokens[0].class.to_s).to eq("ContextIO::ConnectToken")
      end

      it "Can be used to find Contacts." do
        expect(subject.get_contacts[1][0].class.to_s).to eq("ContextIO::Contact")
      end

      it "Can be used to find EmailAdresses" do
        expect(subject.get_email_addresses[1].class.to_s).to eq("ContextIO::EmailAddress")
      end

      it "Can be used to find Files" do
        expect(subject.get_files[1].class.to_s).to eq("ContextIO::Files")
      end

      it "Can be used to find Messages" do
        expect(subject.get_messages[1].class.to_s).to eq("ContextIO::Message")
      end

      it "Can be used to find Sources" do
        expect(subject.get_sources[1].class.to_s).to eq("ContextIO::Sources")
      end

      it "Can be used to find Sync" do
        expect(subject.get_sync.class.to_s).to eq("ContextIO::Sync")
      end

      it "Can be used to find Threads" do
        expect(subject.get_threads.class.to_s).to eq("ContextIO::Threads")
      end

      it "Can be used to find Sources" do
        expect(subject.get_webhooks[1].class.to_s).to eq("ContextIO::Webhook")
      end
    end
  end
end
