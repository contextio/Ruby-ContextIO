module ContextIO
  describe CallHelpers do
    subject { Class.new { extend CallHelpers } }

    it "separates allowed and not allowed parameters" do
      params = subject.validate_params(%i(allowed not_allowed), %i(allowed))
      expect(params.first).to eq Hash(allowed: nil)
      expect(params.last).to eq [:not_allowed]
    end
  end
end
