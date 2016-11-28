require "contextio/connection"
require "contextio/accounts"

require_relative "../utilities/testing_constants.rb"

describe Contacts do
  describe "A Contacts object can be fetched" do
    subject { Contacts.fetch(CONNECTION_BASE,
                             "12345",
                             MOCK_EMAIL,
                             :get) }
    it "Created a Contacts Object" do
      expect(subject.class.to_s).to eq("Contacts")
    end

    it "Was Successful." do
      expect(subject.success).to be true
    end
  end

  describe "A Contacts object created from an Account" do
    #This is "from an Account" because it has the sixth argument of an Account ID
    subject { Contacts.new("Some Parsed JSON",
                            200,
                            true,
                            CONNECTION_BASE,
                            "12345") }

    it "Can be used to find Files" do
      expect(subject.files(MOCK_EMAIL).class.to_s).to eq("Files")
    end
  end
end
