module RequestHelper
  def response
    request.response
  end

  def status
    request.status
  end

  def success?
    request.success
  end
end
