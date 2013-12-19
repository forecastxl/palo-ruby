require 'spec_helper'

describe 'Palo' do
  # This depends on actual palo db settings/user management
  # This should be mocked?
  let(:valid_session) { Palo.login("127.0.0.1", "7777", "admin", "admin") }
  let(:invalid_session) { Palo.login("127.0.0.1", "7777", "admin", "bla") }

  it "returns the correct version string" do
    expect(Palo.version_string).to eq("Palo version #{Palo::VERSION}")
  end

  it "returns the correct api version string" do
    expect(Palo.api_version_string).to eq("Palo DB API version #{Palo::API_VERSION}")
  end

  context "with valid user credentials" do
    it "returns a session after login" do
      expect(valid_session).to be_a(Palo::Session)
    end
  end

  context "with invalid user credentials" do
    xit "raises an error after login" do
      expect { invalid_session }.to raise_error(Palo::PaloError)
    end
  end

  it "can camelize a single word" do
    expect(Palo.camelize("test")).to eq("Test")
  end

  it "can camelize words connected with underscore" do
    expect(Palo.camelize("nog_een_test")).to eq("NogEenTest")
  end

end

describe "PaloError" do
  it "can raise a PaloError with a message" do
    expect { raise Palo::PaloError, 'Oopsie' }.to raise_error(Palo::PaloError, 'Oopsie')
  end
end