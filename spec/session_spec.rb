require 'spec_helper'

describe 'Session' do
  let(:valid_session) { Palo::Session.new("127.0.0.1", "7777", "admin", "admin") }
  let(:invalid_session) { Palo::Session.new("127.0.0.1", "7777", "admin", "bla") }

  context "with valid user credentials" do
    it "returns a session after login" do
      expect(valid_session).to be_a(Palo::Session)
    end

    it "has a session id set" do
      expect(valid_session.sid).not_to eq(nil)
    end

    it "performs a raw query" do
      response = valid_session.query("/server/databases")
      expect { response }.not_to raise_error
    end

    it "returns the server methods class" do
      expect(valid_session.server).to be_an_instance_of(Palo::Server)
    end
  end

  context "with invalid user credentials" do
    xit "raises an error after login" do
      expect { invalid_session }.to raise_error(Palo::PaloError)
    end
  end
end