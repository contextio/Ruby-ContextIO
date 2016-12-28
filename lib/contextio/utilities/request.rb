require_relative "./success_helper"
class Request
  include ::SuccessHelper
  attr_reader :response, :status, :success
  def initialize(connection, method, url)
    request = connection.connect.send(method, url)
    @response = JSON.parse(request.body)
    @status = request.status
    @success =  check_success(request.status)
  end
end
