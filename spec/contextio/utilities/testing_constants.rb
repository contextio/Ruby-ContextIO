module TestingConstants

  CIO_2_POINT_0_OBJECT = ContextIO::ContextIO.new(key: "api key",
                                                  secret: "secret key")
  MOCK_EMAIL = "some_email@some_provider.com".freeze

  MOCK_OAUTH_PROVIDER = ContextIO::OauthProvider.new(parent: TestingConstants::CIO_2_POINT_0_OBJECT, identifier: "a_key")

  MOCK_ACCOUNT = ContextIO::Account.new(parent: TestingConstants::CIO_2_POINT_0_OBJECT, identifier: "some_id")

  MOCK_FARADAY_OBJECT_FAILURE_BODY = []

  SUCCESSFUL_CALL = 200

  UNSUCCESSFUL_CALL = "404".freeze

  ACCOUNT_PARENT = ContextIO::Account.new(identifier: "some_id", parent: CIO_2_POINT_0_OBJECT)

  SOURCE_PARENT = ContextIO::Sources.new(identifier: "0",
                                         parent: ACCOUNT_PARENT)

  MOCK_CONTACT = ContextIO::Contact.new(parent: ACCOUNT_PARENT,
                                        identifier: "some_email@some_provider.com")

  MOCK_ACCOUNT_MESSAGE = ContextIO::Message.new(parent: ACCOUNT_PARENT,
                                                identifier: "12345")

  MOCK_ACCOUNT_FILE =  ContextIO::Files.new(identifier: "some_file", parent: ACCOUNT_PARENT)

  MOCK_SOURCE = ContextIO::Sources.new(parent: ACCOUNT_PARENT,
                                       identifier: "0")

  MOCK_THREADS = ContextIO::Threads.new(parent: ACCOUNT_PARENT,
                                       identifier: "some_thread")

  MOCK_WEBHOOK = ContextIO::Webhook.new(parent: CIO_2_POINT_0_OBJECT,
                                        identifier: "a_webhook_id")

  MOCK_ACCOUNT_WEBHOOK = ContextIO::Webhook.new(parent: ACCOUNT_PARENT,
                                                identifier: "a_webhook_id")

  MOCK_SOURCE_FOLDER = ContextIO::Folder.new(parent: SOURCE_PARENT,
                                             identifier: "[Gmail]/Sent Mail")
end
