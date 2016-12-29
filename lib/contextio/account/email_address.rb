module ContextIO
  class EmailAddress < BaseClass
    EMAIL_ATTRS = %I(email validated primary)

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
        response.each { |k,v| instance_variable_set("@#{k}", v) }
      end
    end

    def get
      request = Request.new(parent.connection, :get, "/2.0/accounts/#{account_id}/email_addresses/#{email}")
      EmailAddress.new(parent: parent,
                       account_id: account_id,
                       identifier: email,
                       response: request.response,
                       status: request.status,
                       success: request.success)
    end
  end
end
