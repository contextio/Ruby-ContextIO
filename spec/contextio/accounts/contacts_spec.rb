require "contextio/connection"
require "contextio"


require_relative "../utilities/testing_constants.rb"
require_relative "../utilities/mock_response.rb"

describe Contacts do
  describe "A Contacts object created from an Account" do
    #This is "from an Account" because it has the sixth argument of an Account ID
    subject { MockResponse::MOCK_CONTACT }

    it "Can be used to find Files" do
      expect(subject.files(MOCK_EMAIL).class.to_s).to eq("Files")
    end
  end
end
