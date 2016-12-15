module RequestHelper
  def collection_return(request, connection, klass, identifier)
    responses = JSON.parse(request.response)

    responses.map do |resp|
      klass.new(connection,
                resp,
                request.status,
                request.success,
                resp[identifier])
    end
  end

  def success?
    self.success
  end
end
