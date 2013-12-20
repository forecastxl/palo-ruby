require 'spec_helper'

describe "Dimension" do
  let(:session) { Palo.login("127.0.0.1", "7777", "admin", "admin") }
  
  it "returns a dimension object from a session" do
    expect(session.dimension).to be_an_instance_of(Palo::Dimension::Base)
  end

  it "returns a dimension object with public methods" do
    methods = %w(clear create cubes destroy element elements info rename dfilter)
    expect(session.dimension.public_methods.map(&:to_s)).to include(*methods)
  end

  
end