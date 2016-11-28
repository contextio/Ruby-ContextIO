require "contextio/request"

describe Request do
  describe "Determine API endpoint returns the proper URL" do
    it "Returns a Contacts URL when from_a_contact is true" do
      expect(Request.determine_api_endpoint("12345",
                                            "email",
                                            "contacts",
                                            true)).to eq("/2.0/accounts/12345/contacts/email/files")
    end

    it "Returns an Accounts and Email URL when given an email" do
      expect(Request.determine_api_endpoint("12345",
                                            "email",
                                            "files")).to eq("/2.0/accounts/12345/files/email")
    end

    it "Returns an Accounts and Email URL when given an email" do
      expect(Request.determine_api_endpoint("12345",
                                            nil,
                                            "files")).to eq("/2.0/accounts/12345/files")
    end
  end
end
