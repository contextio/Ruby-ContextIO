module TestingConstants

  CIO_2_POINT_0_OBJECT = ContextIO::ContextIO.new(key: "api key",
                                                  secret: "secret key",
                                                  version: "2.0")
  MOCK_EMAIL = "some_email@some_provider.com".freeze

  MOCK_OAUTH_PROVIDER = ContextIO::OauthProvider.new(parent: TestingConstants::CIO_2_POINT_0_OBJECT, identifier: "a_key")

  MOCK_ACCOUNT = ContextIO::Account.new(parent: TestingConstants::CIO_2_POINT_0_OBJECT, identifier: "some_id")

  MOCK_FARADAY_OBJECT_FAILURE_BODY = []

  SUCCESSFUL_CALL = 200

  UNSUCCESSFUL_CALL = "404".freeze

  account_parent = ContextIO::Account.new(identifier: "some_id", parent: CIO_2_POINT_0_OBJECT)

  source_parent = ContextIO::Sources.new(identifier: "0",
                                         parent: account_parent)

  MOCK_CONTACT = ContextIO::Contact.new(parent: account_parent,
                                        identifier: "some_email@some_provider.com")

  MOCK_ACCOUNT_MESSAGE = ContextIO::Message.new(parent: account_parent,
                                                identifier: "12345")

  MOCK_ACCOUNT_FILE =  ContextIO::Files.new(identifier: "some_file", parent: account_parent)

  MOCK_SOURCE = ContextIO::Sources.new(parent: account_parent,
                                       identifier: "0")

  MOCK_THREADS = ContextIO::Threads.new(parent: account_parent,
                                       identifier: "some_thread")

  MOCK_WEBHOOK = ContextIO::Webhook.new(parent: account_parent,
                                       identifier: "some_webhook")

  MOCK_SOURCE_FOLDER = ContextIO::Folder.new(parent: source_parent,
                                             identifier: "[Gmail]/Sent Mail")
end
