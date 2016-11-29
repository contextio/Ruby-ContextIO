module MockResponse

  Struct.new("MockFaraday", :body, :status)

  MOCK_FARADAY_SUCCESS_BODY = "{\"id\":\"12345\",\"username\":\"someemail.gmail.com_12345\",
    \"created\":0,\"email_addresses\":[\"someemail@gmail.com\"],
    \"first_name\":\"Some\",\"last_name\":\"Account\",\"password_expired\":0,\"nb_messages\":2067,
    \"sources\":[{\"server\":\"imap.googlemail.com\",\"label\":\"someemail::gmail\",
    \"mailserviceAccountId\":null,\"username\":\"someemail@gmail.com\",\"port\":993,
    \"authentication_type\":\"oauth2\",\"use_ssl\":true,\"status\":\"OK\",\"sync_flags\":false,
    \"type\":\"imap\",\"resource_url\":\"https:\\/\\/api.context.io\\/2.0\\/accounts\\/1234\\/sources\\/someemail%3A%3Agmail\"}]}".freeze

  FROM_ACCOUNT_MOCK_FARADAY_SUCCESS_BODY = "{\"id\":\"12345\",\"username\":\"fromaccount.gmail.com_12345\",
    \"created\":0,\"email_addresses\":[\"fromacccount@gmail.com\"],
    \"first_name\":\"Some\",\"last_name\":\"Account\",\"password_expired\":0,\"nb_messages\":2067,
    \"sources\":[{\"server\":\"imap.googlemail.com\",\"label\":\"someemail::gmail\",
    \"mailserviceAccountId\":null,\"username\":\"someemail@gmail.com\",\"port\":993,
    \"authentication_type\":\"oauth2\",\"use_ssl\":true,\"status\":\"OK\",\"sync_flags\":false,
    \"type\":\"imap\",\"resource_url\":\"https:\\/\\/api.context.io\\/2.0\\/accounts\\/1234\\/sources\\/someemail%3A%3Agmail\"}]}".freeze


  MOCK_FARADAY_OBJECT_FAILURE_BODY = []

  SUCCESSFUL_CALL = 200

  MOCK_FARADAY = Struct::MockFaraday.new(MOCK_FARADAY_SUCCESS_BODY, SUCCESSFUL_CALL)

  UNSUCCESSFUL_CALL = "404".freeze

  ACCOUNTS = [{"created"=>0,
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
     {"created"=>0,
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
end
