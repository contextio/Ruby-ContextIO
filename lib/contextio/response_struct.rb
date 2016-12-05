class ResponseStruct < Struct.new(:response, :status, :success)
  def check_success(status)
    status >= 200 && status <= 299
  end
end
