require_relative './testing_constants'
module MockResponse

  Struct.new("MockFaraday", :response, :status, :success)

  MOCK_FARADAY_SUCCESS_BODY = "{\"id\":\"some_id\",\"username\":\"someemail.gmail.com_12345\",
    \"created\":0,\"email_addresses\":[\"someemail@gmail.com\"],
    \"first_name\":\"Some\",\"last_name\":\"Account\",\"message_id\":\"12345\",\"password_expired\":0,\"nb_messages\":2067,
    \"sources\":[{\"server\":\"imap.googlemail.com\",\"label\":\"someemail::gmail\",
    \"mailserviceAccountId\":null,\"username\":\"someemail@gmail.com\",\"port\":993,
    \"authentication_type\":\"oauth2\",\"use_ssl\":true,\"status\":\"OK\",\"sync_flags\":false,
    \"type\":\"imap\",\"resource_url\":\"https:\\/\\/api.context.io\\/2.0\\/accounts\\/1234\\/sources\\/someemail%3A%3Agmail\"}]}".freeze

  CONTACT_COLLECTION_FARADAY_SUCCESS_BODY = "{\"query\":{\"limit\":25,\"offset\":null,
  \"active_after\":null,\"active_before\":null,\"search\":null},\"matches\":[{\"email\":\"an_account_email_address\",
  \"count\":1,\"sent_count\":0,\"received_count\":1,\"sent_from_account_count\":0,
  \"thumbnail\":\"an_avatar\", \"name\":\"Yahoo Mail\",\"resource_url\":\"a_resource_url\",
  \"last_sent\":null,\"last_received\":1479499953},{\"email\":\"sent_from_email\",
  \"count\":7,\"sent_count\":7,\"received_count\":0,\"sent_from_account_count\":0,
  \"thumbnail\":\"an_avatar\", \"resource_url\":\"a_resource_url\", \"last_sent\":1480690829,
  \"last_received\":null},{\"email\":\"an_email\",\"count\":1,\"sent_count\":0,\"received_count\":1,
  \"sent_from_account_count\":0,\"thumbnail\":\"an_avatar\", \"name\":\"a_name\",
  \"resource_url\":\"https:\\/\\/api.context.io\\/2.0\\/accounts\\/582f618c4968c3e22e8b4567\\/contacts\\/noreply%40yahoo-inc.com\",
  \"last_sent\":null,\"last_received\":1479500065},{\"email\":\"no-reply@cc.yahoo-inc.com\",
  \"count\":1,\"sent_count\":0,\"received_count\":1,\"sent_from_account_count\":0,
  \"thumbnail\":\"https:\\/\\/secure.gravatar.com\\/avatar\\/e76eb6902fca74276e63b02737af201e?s=50&d=https%3A%2F%2Fs3.amazonaws.com%2Fcontextio-icons%2Fcontact.png\",
  \"name\":\"Yahoo\",\"resource_url\":\"https:\\/\\/api.context.io\\/2.0\\/accounts\\/582f618c4968c3e22e8b4567\\/contacts\\/no-reply%40cc.yahoo-inc.com\",
  \"last_sent\":null,\"last_received\":1479500156},{\"email\":\"yahoo@communications.yahoo.com\",
  \"count\":4,\"sent_count\":0,\"received_count\":4,\"sent_from_account_count\":0,
  \"thumbnail\":\"https:\\/\\/secure.gravatar.com\\/avatar\\/93915285723ad8335bcebfa1a4df0ec5?s=50&d=https%3A%2F%2Fs3.amazonaws.com%2Fcontextio-icons%2Fcontact.png\",
  \"name\":\"Yahoo Mail\",\"resource_url\":\"https:\\/\\/api.context.io\\/2.0\\/accounts\\/582f618c4968c3e22e8b4567\\/contacts\\/yahoo%40communications.yahoo.com\",
  \"last_sent\":null,\"last_received\":1480690829}]}"

  ACCOUNT_COLLECTION_FARADAY_SUCCESS_BODY = "[{\"message_id\":\"a_message_id\",\"label\":\"a_label\",\"file_id\":\"a_file_id\",
  \"email\":\"an_email\",\"webhook_id\":\"a_webhook_id\",\"key\":\"a_key\",
  \"id\":\"an_id\",\"token\":\"a_token\",\"type\":\"image\\/png\",\"size\":49516,
  \"subject\":\"Test-1-2 Test-1-2\",\"date\":1111111111,\"addresses\":{\"from\":{\"an account\":\"an_email\",
  \"name\":\"A name\"},\"to\":[{\"email\":\"a_second_email\"}]},\"file_name\":\"Screen Shot\",
  \"body_section\":\"2\",\"content_disposition\":\"attachment\",\"file_id\":\"an_id\",
  \"is_tnef_part\":false,\"supports_preview\":false,\"message_id\":\"an_id\",
  \"email_message_id\":\"an_id\",\"date_indexed\":23423423432,\"date_received\":43534534,
  \"person_info\":{\"an_email\":{\"thumbnail\":\"a_thumbnail\"},
  \"gundam_reference@gmail.com\":{\"thumbnail\":\"a_thumbnail\"}},
  \"file_name_structure\":[[\"A file\",\"main\"],[\" \",\"boundary\"],[\"dasdassad\",
  \"date\"],[\".png\",\"ext\"]],\"is_embedded\":false,\"resource_url\":\"a url\"},
  {\"type\":\"image\\/png\",\"size\":49516,
  \"subject\":\"Test-1-2 Test-1-2\",\"date\":1111111111,\"addresses\":{\"from\":{\"an account\":\"an_email\",
  \"name\":\"A name\"},\"to\":[{\"email\":\"a_second_email\"}]},\"file_name\":\"Screen Shot\",
  \"body_section\":\"2\",\"content_disposition\":\"attachment\",\"file_id\":\"an_id\",
  \"is_tnef_part\":false,\"supports_preview\":false,\"message_id\":\"an_id\",
  \"email_message_id\":\"an_id\",\"date_indexed\":23423423432,\"date_received\":43534534,
  \"person_info\":{\"an_email\":{\"thumbnail\":\"a_thumbnail\"},
  \"gundam_reference@gmail.com\":{\"thumbnail\":\"a_thumbnail\"}},
  \"file_name_structure\":[[\"A file\",\"main\"],[\" \",\"boundary\"],[\"dasdassad\",
  \"date\"],[\".png\",\"ext\"]],\"is_embedded\":false,\"resource_url\":\"a url\"}]"


  NON_ACCOUNT_COLLECTION_FARADAY_SUCCESS_BODY = "[{\"email\":\"an_email\",\"type\":\"image\\/png\",\"size\":49516,
  \"subject\":\"Test-1-2 Test-1-2\",\"date\":1111111111,\"addresses\":{\"from\":{\"email\":\"an_email\",
  \"name\":\"A name\"},\"to\":[{\"email\":\"a_second_email\"}]},\"file_name\":\"Screen Shot\",
  \"body_section\":\"2\",\"content_disposition\":\"attachment\",\"file_id\":\"an_id\",
  \"is_tnef_part\":false,\"supports_preview\":false,\"message_id\":\"an_id\",
  \"email_message_id\":\"an_id\",\"date_indexed\":23423423432,\"date_received\":43534534,
  \"person_info\":{\"an_email\":{\"thumbnail\":\"a_thumbnail\"},
  \"gundam_reference@gmail.com\":{\"thumbnail\":\"a_thumbnail\"}},
  \"file_name_structure\":[[\"A file\",\"main\"],[\" \",\"boundary\"],[\"dasdassad\",
  \"date\"],[\".png\",\"ext\"]],\"is_embedded\":false,\"resource_url\":\"a url\"}]"

  FROM_ACCOUNT_MOCK_FARADAY_SUCCESS_BODY = "{\"id\":\"some_id\",\"username\":\"fromaccount.gmail.com_12345\",
    \"created\":0,\"email_addresses\":[\"fromacccount@gmail.com\"],
    \"first_name\":\"Some\",\"last_name\":\"Account\",\"message_id\":\"12345\",\"password_expired\":0,\"nb_messages\":2067,
    \"sources\":[{\"server\":\"imap.googlemail.com\",\"label\":\"someemail::gmail\",
    \"mailserviceAccountId\":null,\"username\":\"someemail@gmail.com\",\"port\":993,
    \"authentication_type\":\"oauth2\",\"use_ssl\":true,\"status\":\"OK\",\"sync_flags\":false,
    \"type\":\"imap\",\"resource_url\":\"https:\\/\\/api.context.io\\/2.0\\/accounts\\/1234\\/sources\\/someemail%3A%3Agmail\"}]}".freeze


end
