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

    #Webhooks
    WEBHOOK = %I(callback_url failure_notif_url filter_to filter_from filter_cc
                  filter_subject filter_thread filter_file_name filter_folder_added
                  filter_folder_removed filter_to_domain filter_from_domain
                  include_body body_type include_header)


    OAUTH_PROVIDER = %I(type provider_consumer_key provider_consumer_secret)
  end
end
