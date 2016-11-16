require "contextio/accounts"

RESPONSE = [{"created"=>1475765868,
    "username"=>"some_accoount.gmail.com_some_numbers",
    "suspended"=>nil,
    "id"=>"some_numbers",
    "email_addresses"=>["some_accoount.gmail.com"],
    "first_name"=>"Some",
    "last_name"=>"Account",
    "password_expired"=>0,
    "sources"=>
     [{"server"=>"imap.googlemail.com",
       "label"=>"some_account::gmail",
       "username"=>"some_account.com",
       "port"=>993,
       "authentication_type"=>"oauth2",
       "use_ssl"=>true,
       "status"=>"OK",
       "type"=>"imap",
       "resource_url"=>"https://api.context.io/2.0/accounts/"}],
    "resource_url"=>"https://api.context.io/2.0/accounts/"},
   {"created"=>1479162410,
    "username"=>"asecondaccount.gmail.com_some_numbers",
    "suspended"=>nil,
    "id"=>"some_other_numbers",
    "email_addresses"=>["asecondaccount@gmail.com"],
    "first_name"=>"Amuro",
    "last_name"=>"Ray",
    "password_expired"=>0,
    "sources"=>
     [{"server"=>"imap.googlemail.com",
       "label"=>"asecondaccount::gmail",
       "username"=>"qsecondaccount@gmail.com",
       "port"=>993,
       "authentication_type"=>"oauth2",
       "use_ssl"=>true,
       "status"=>"OK",
       "type"=>"imap",
       "resource_url"=>"https://api.context.io/2.0/accounts/"}],
    "resource_url"=>"https://api.context.io/2.0/accounts/"}].freeze

describe Accounts do
  describe "An Accounts object holding more than one account" do
    subject { Accounts.new(RESPONSE, "secret") }

    it "Returns an onject with an error if a method is called on it" do
      expect(subject.connect_tokens.success?).to be false
    end
  end

end
