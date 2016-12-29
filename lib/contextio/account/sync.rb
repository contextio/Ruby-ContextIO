module ContextIO
  class Sync < BaseClass
    include CollectionHelper
    attr_reader :response, :status, :success
    def initialize(request)
      @response = request.response
      @status = request.status
      @success =  request.success
    end
  end
end
