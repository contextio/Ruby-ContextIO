module ContextIO
  module ValidPostParams
    #Accounts
    ACCOUNTS = %I(expunge_on_deleted_flag sync_all_folders raw_file_list password
                  provider_refresh_token provider_consumer_key callback_url
                  status_callback_url use_ssl email server username port type
                  migrate_account_id)

    ACCOUNT = %I(first_name last_name)

    #Connect Tokens
    CONNECT_TOKEN = %I(email last_name source_callback_url source_expunge_on_deleted_flag
                       source_sync_all_folders source_sync_folders source_raw_file_list
                       status_callback_url callback_url)

    #Messages
    MESSAGE = %I(flag_seen flag_answered flag_flagged flag_deleted flag_draft
                 message dst_source dst_folder)

    MESSAGE_MOVE_20 = %I(dst_source move flag_seen flag_answered flag_flagged
                         flag_deleted flag_draft dst_folder)

    #Sources
    SOURCES = %I(email server username	use_ssl port type password origin_ip
                expunge_on_deleted provider_refresh_token	string provider_consumer_key
                sync_all_folders callback_url status_callback_url)

    #Webhooks
    WEBHOOKS = %I(callback_url failure_notif_url filter_to filter_from filter_cc
                 filter_subject filter_thread filter_file_name filter_folder_added
                 filter_folder_removed filter_to_domain filter_from_domain
                 include_body body_type include_header)


    OAUTH_PROVIDER = %I(type provider_consumer_key provider_consumer_secret)
  end
end
