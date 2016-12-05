require "contextio/connection"
require "contextio"


require_relative "../utilities/testing_constants.rb"
require_relative "../utilities/mock_response.rb"

describe Contacts do
  describe "A Contacts object can be fetched" do
    subject { Contacts.fetch(CONNECTION_BASE,
                             "some_id",
                             MOCK_EMAIL,
                             :get) }
    it "Created a Contacts Object" do
      expect(subject.class.to_s).to eq("Contacts")
    end

    it "Was Successful." do
      expect(subject.success?).to be true
    end
  end

  describe "A Contacts object created from an Account" do
    #This is "from an Account" because it has the sixth argument of an Account ID
    subject { Contacts.new(MockResponse::MOCK_FARADAY,
                           CONNECTION_BASE,
                           "some_id") }

    it "Can be used to find Files" do
      expect(subject.files(MOCK_EMAIL).class.to_s).to eq("Files")
    end
  end
end
