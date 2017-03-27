module ContextIO
  module ValidParams

    # Accounts
    GET_ACCOUNTS= %I(email status status_ok limit offset)

    #Contacts
    GET_CONTACTS = %I(search activity_before activity_after sort_by sort_order limit offset)

    GET_CONTACT_FILES = %I(limit offset)

    GET_CONTACT_MESSAGES = %I(limit offset)

    GET_CONTACT_THREADS = %I(limit offset)

    #Files
    GET_FILES = %I(file_name file_size_min file_size_max email to from cc bcc
                          date_before date_after indexed_before indexed_after source
                          sort_order limit offset)

    GET_FILE_CONTENT = %I(as_link)

    #Messages
    GET_MESSAGES = %I(subject email to from cc bcc folder source file_name file_size_min
                             file_size_max date_before date_after indexed_before indexed_after
                             include_thread_size include_body include_headers include_flags
                             body_type include_source sort_order limit offset)

    #Account/Threads
    GET_THREADS = %I(subject email to from cc bcc folder indexed_before indexed_after
                            activity_before activity_after started_before started_after
                            limit offset)
    #Threads
    THREADS_GET = %I(include_body include_headers include_flags body_type
                            include_source limit offset)

    #Sources
    GET_SOURCES =  %I(status status_ok)


    FOLDERS_SOURCES_GET = %I(include_extended_counts no_cache)

    GET_SOURCE_FOLDER = %I(include_extended_counts delim)

    GET_SOURCE_FOLDER_MESSAGES = %I(include_thread_size include_body body_type
                                           include_headers include_flags flag_seen
                                           limit offset)

    #Messages
    MESSAGE_GET = %I(include_thread_size include_body include_headers include_flags
                            body_type include_source)

  end
end
