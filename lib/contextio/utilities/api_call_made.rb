module ContextIO
  module APICallMade
    CALL_MADE_STRUCT= Struct.new(:url, :method, :allowed_params, :rejected_params)
  end
end
