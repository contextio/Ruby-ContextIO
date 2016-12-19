module RequestHelper
  def collection_return(request, context_io, klass, identifier)
    request.response.map do |resp|
      klass.new(context_io,
                resp[identifier],
                resp,
                request.status,
                request.success)
    end
  end

  def contact_collection_return(request, context_io)
    response = request.response
    matches = response["matches"].map do |resp|
      Contact.new(context_io,
                  resp["email"],
                  resp,
                  request.status,
                  request.success)
    end
    [response["query"], matches]
  end

  def success?
    self.success
  end
end
