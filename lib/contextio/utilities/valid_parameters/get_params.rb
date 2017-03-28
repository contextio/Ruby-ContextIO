module ContextIO
  module ValidGetParams

    # Accounts
    ACCOUNTS= %I(email status status_ok limit offset)

    #Contacts
    CONTACTS = %I(search activity_before activity_after sort_by sort_order limit offset)

    CONTACT_FILES = %I(limit offset)

    CONTACT_MESSAGES = %I(limit offset)

    CONTACT_THREADS = %I(limit offset)

    #Files
    FILES = %I(file_name file_size_min file_size_max email to from cc bcc
                   date_before date_after indexed_before indexed_after source
                   sort_order limit offset)

    FILE_CONTENT = %I(as_link)

    #Messages
    MESSAGES = %I(subject email to from cc bcc folder source file_name file_size_min
                      file_size_max date_before date_after indexed_before indexed_after
                      include_thread_size include_body include_headers include_flags
                      body_type include_source sort_order limit offset)

    MESSAGE_THREADS = %I(include_body include_headers include_flags body_type
                             limit offset)

    #Threads
    THREADS = %I(subject email to from cc bcc folder indexed_before indexed_after
                     activity_before activity_after started_before started_after
                     limit offset)

    THREAD = %I(include_body include_headers include_flags body_type
                     include_source limit offset)

    #Sources
    SOURCES =  %I(status status_ok)


    FOLDERS_SOURCES = %I(include_extended_counts no_cache)

    SOURCE_FOLDER = %I(include_extended_counts delim)

    SOURCE_FOLDER_MESSAGES = %I(include_thread_size include_body body_type
                                    include_headers include_flags flag_seen
                                    limit offset)

    #Messages
    MESSAGE = %I(include_thread_size include_body include_headers include_flags
                     body_type include_source)

    MESSAGE_BODY = %I(type)

    MESSAGE_HEADER = %I(raw)

  end
end
