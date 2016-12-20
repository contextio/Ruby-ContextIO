class EmailAddress
  EMAIL_ATTRS = %I(email validated primary)

  private
  attr_reader :context_io

  public
  include RequestHelper
  attr_reader :response, :status, :success, :account_id, :email, *EMAIL_ATTRS
  def initialize(context_io:,
                 account_id:,
                 identifier: nil,
                 response: nil,
                 status: nil,
                 success: nil)
    @context_io = context_io
    @account_id = account_id
    @email = identifier
    @status = status
    @success =  success
    if response
      response.each { |k,v| instance_variable_set("@#{k}", v) }
    end
  end

  def get
    request = Request.new(context_io.connection, :get, "/2.0/accounts/#{account_id}/email_addresses/#{email}")
    EmailAddress.new(context_io: context_io,
                     account_id: account_id,
                     identifier: email,
                     response: request.response,
                     status: request.status,
                     success: request.success)
  end
end
