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

    FLAGS = %I(seen answered flagged deleted draft)

    #Sources
    SOURCES = %I(email server username	use_ssl port type password origin_ip
                expunge_on_deleted provider_refresh_token	string provider_consumer_key
                sync_all_folders callback_url status_callback_url)

    SOURCE = %I(status force_status_check sync_all_folders expunge_on_deleted_flag
                password provider_refresh_token provider_consumer_key status_callback_url)

    SOURCE_CONNECT_TOKEN = %I(callback_url)

    #Webhooks
    WEBHOOKS = %I(callback_url filter_to filter_from filter_cc
                  filter_subject filter_thread filter_file_name filter_folder_added
                  filter_to_domain filter_from_domain
                  include_body body_type include_header)

   WEBHOOK = %I(callback_url filter_to filter_from filter_cc
                filter_subject filter_thread filter_file_name filter_folder_added
                filter_to_domain filter_from_domain
                include_body body_type include_header active)

    OAUTH_PROVIDER = %I(type provider_consumer_key provider_consumer_secret)
  end
end
