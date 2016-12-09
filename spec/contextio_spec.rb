require "spec_helper"

describe ContextIO do
  it "has a version number" do
    expect(ContextIO::VERSION).not_to be false
  end

  describe "new ContextIO object" do
    subject { ContextIO::ContextIO.new("key", "secret") }

    it "needs arguments to for a ContextIO object" do
      expect{ ContextIO::ContextIO.new() }.to raise_error(ArgumentError)
    end

    it "has a connection on creation" do
      expect(subject.connection).not_to be nil
    end

    it "has a connection that is a Connection" do
      expect(subject.connection.class.to_s).to eq("Connection")
    end

    it "can return an Accounts object" do
      expect(subject.accounts("some_id").class.to_s).to eq("Accounts")
    end
  end
end
