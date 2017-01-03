module TestingConstants
  Struct.new("MockParent", :connection, :call_url)


  CIO_2_POINT_0_OBJECT = ContextIO::ContextIO.new(key: "api key",
                                                  secret: "secret key",
                                                  version: "2.0")
  MOCK_EMAIL = "some_email@some_provider.com".freeze

  MOCK_ACCOUNT = ContextIO::Account.new(parent: TestingConstants::CIO_2_POINT_0_OBJECT, identifier: "some_id")

  MOCK_FARADAY_OBJECT_FAILURE_BODY = []

  SUCCESSFUL_CALL = 200

  UNSUCCESSFUL_CALL = "404".freeze

  contact_parent = Struct::MockParent.new(CIO_2_POINT_0_OBJECT.connection, "2.0/accounts/some_id")

  MOCK_CONTACT = ContextIO::Contact.new(parent: contact_parent,
                                        identifier: "some_email@some_provider.com")
end
