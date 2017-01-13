module TestingConstants
  Struct.new("MockParent", :connection, :call_url)


  CIO_2_POINT_0_OBJECT = ContextIO::ContextIO.new(key: "api key",
                                                  secret: "secret key",
                                                  version: "2.0")
  MOCK_EMAIL = "some_email@some_provider.com".freeze

  MOCK_OAUTH_PROVIDER = ContextIO::OauthProvider.new(parent: TestingConstants::CIO_2_POINT_0_OBJECT, identifier: "some_key")

  MOCK_ACCOUNT = ContextIO::Account.new(parent: TestingConstants::CIO_2_POINT_0_OBJECT, identifier: "some_id")

  MOCK_FARADAY_OBJECT_FAILURE_BODY = []

  SUCCESSFUL_CALL = 200

  UNSUCCESSFUL_CALL = "404".freeze

  account_parent = Struct::MockParent.new(CIO_2_POINT_0_OBJECT.connection, "2.0/accounts/some_id")

  source_parent = Struct::MockParent.new(CIO_2_POINT_0_OBJECT.connection, "2.0/accounts/some_id/sources/0")

  MOCK_CONTACT = ContextIO::Contact.new(parent: account_parent,
                                        identifier: "some_email@some_provider.com")

  MOCK_SOURCE = ContextIO::Sources.new(parent: account_parent,
                                       identifier: "0")

  MOCK_SOURCE_FOLDER = ContextIO::Folder.new(parent: source_parent,
                                             identifier: "[Gmail]/Sent Mail")
end
