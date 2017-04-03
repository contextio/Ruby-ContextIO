module ContextIO
  module ValidPostParams
    #Accounts
    ACCOUNTS = %I(expunge_on_deleted_flag sync_all_folders raw_file_list password
                  provider_refresh_token provider_consumer_key callback_url
                  status_callback_url use_ssl email server username port type
                  migrate_account_id)

    ACCOUNT = %I(first_name last_name)

    #Connect Tokens

    CONNECT_TOKENS = %I(email last_name source_callback_url source_expunge_on_deleted_flag
                        source_sync_all_folders source_sync_folders source_raw_file_list
                        status_callback_url callback_url)
  end
end
