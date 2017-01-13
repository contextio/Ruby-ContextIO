module ContextIO
  class Folder < BaseClass
    FOLDER_READERS = %I(symbolic_name attributes delim nb_messages xlist_name
                        nb_unseen_messages resource_url)

    private
    attr_reader :parent

    public
    attr_reader :status, :success, :connection, :name, :response, *FOLDER_READERS
    def initialize(parent:,
                   identifier: nil,
                   response: nil,
                   status: nil,
                   success: nil)
      @status = status
      @success =  success
      @parent = parent
      @connection = parent.connection
      @name = identifier
      if response
        parse_response(response)
      end
    end

    def call_url
      build_url("folders", name)
    end
  end
end
