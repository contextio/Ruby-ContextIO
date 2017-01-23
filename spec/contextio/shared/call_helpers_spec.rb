module ContextIO
  describe CallHelpers do
    let(:call_helper) { Class.new { extend CallHelpers } }
    subject { call_helper.get_params([:allowed, :not_allowed],[:allowed]) }

    it "rejected not_allowed parameters" do
      subject[1] == [:not_allowed]
    end

    it "allowed correct parameters" do
      subject[0] == [:allowed]
    end
  end
end
