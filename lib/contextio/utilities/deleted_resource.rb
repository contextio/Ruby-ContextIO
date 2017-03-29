module ContextIO
  class DeletedResource
    attr_reader :response, :status, :success, :api_call_made, :identifier
    def initialize(response:,
                   status:,
                   success:,
                   api_call_made:)
    @response = response
    @status = status
    @success = success
    @api_call_made = api_call_made
    @identifier = api_call_made.url.to_s.split("/").last
    end
  end
end
