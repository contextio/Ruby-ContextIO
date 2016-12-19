module RequestHelper
  def collection_return(request, context_io, klass, identifier, account_id)
    request.response.map do |resp|
      klass.new(context_io: context_io,
                account_id: account_id,
                identifier: resp[identifier],
                response: resp,
                status: request.status,
                success: request.success)
    end
  end

  def contact_collection_return(request, context_io, account_id)
    response = request.response
    matches = response["matches"].map do |resp|
      Contact.new(response: resp,
                  status: request.status,
                  success: request.success,
                  context_io: context_io,
                  identifier: resp["email"],
                  account_id: account_id)
    end
    [response["query"], matches]
  end

  def success?
    self.success
  end
end
