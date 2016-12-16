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

  def success?
    self.success
  end
end
