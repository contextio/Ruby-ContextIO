module ContextIO
  module ValidParams
    GET_ACCOUNTS_PARAMS= %I(email status status_ok limit offset)

    GET_CONTACTS_PARAMS = %I(search activity_before activity_after sort_by sort_order limit offset)

    GET_FILES_PARAMS = %I(file_name file_size_min file_size_max email to from cc bcc
                          date_before date_after indexed_before indexed_after source
                          sort_order limit offset)

    GET_MESSAGES_PARAMS = %I(subject email to from cc bcc folder source file_name file_size_min
                             file_size_max date_before date_after indexed_before indexed_after
                             include_thread_size include_body include_headers include_flags
                             body_type include_source sort_order limit offset)

     GET_THREADS_PARAMS = %I(subject email to from cc bcc folder indexed_before indexed_after
                             activity_before activity_after started_before started_after
                             limit offset)
  end
end
