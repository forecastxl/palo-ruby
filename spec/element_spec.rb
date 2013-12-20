require 'spec_helper'

describe "Element" do
  let(:session) { Palo.login("127.0.0.1", "7777", "admin", "admin") }
  
  it "returns a element object from a session" do
    expect(session.element).to be_an_instance_of(Palo::Element::Base)
  end

  it "returns a element object with public methods" do
    methods = %w(append create create_bulk destroy destroy_bulk info move rename replace replace_bulk)
    expect(session.element.public_methods.map(&:to_s)).to include(*methods)
  end

  
end