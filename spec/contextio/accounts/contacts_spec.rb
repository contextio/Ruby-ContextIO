require "contextio/connection"
require "contextio"


require_relative "../utilities/testing_constants.rb"
require_relative "../utilities/mock_response.rb"

describe Contact do
  describe "A Contacts object created from an Account" do
    #This is "from an Account" because it has the sixth argument of an Account ID
    subject { MockResponse::MOCK_CONTACT }
  end
end
