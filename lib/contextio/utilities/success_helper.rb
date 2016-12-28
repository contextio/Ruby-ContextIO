module ContextIO
  module SuccessHelper
    def check_success(status)
      status >= 200 && status <= 299
    end

    def success?
      self.success
    end
  end
end
