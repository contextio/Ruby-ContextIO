module ContextIO
  class EmailAddress < BaseClass
    EMAIL_ATTRS = %I(email validated primary resource_url)

    private
    attr_reader :connection

    public
    include CollectionHelper
    attr_reader :response, :status, :parent, :success, :email, *EMAIL_ATTRS
    def initialize(parent:,
                   account_id: nil,
                   identifier: nil,
                   response: nil,
                   status: nil,
                   success: nil)
      @parent = parent
      @account_id = account_id
      @email = identifier
      @status = status
      @success =  success
      if response
        parse_response(response)
      end
    end

    def get
      call_api
    end
  end
end
