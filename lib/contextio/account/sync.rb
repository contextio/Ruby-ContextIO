module ContextIO
  class Sync < BaseClass
    include RequestHelper
    attr_reader :response, :status, :success
    def initialize(request)
      @response = request.response
      @status = request.status
      @success =  request.success
    end
  end
end
