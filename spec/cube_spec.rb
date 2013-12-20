require 'spec_helper'

describe "Cube" do
  let(:session) { Palo.login("127.0.0.1", "7777", "admin", "admin") }
  
  it "returns a cube object from a session" do
    expect(session.cube).to be_an_instance_of(Palo::Cube::Base)
  end

  it "returns a cube object with public methods" do
    methods = %w(clear commit create convert destroy info load lock locks rename rollback rules save unload)
    expect(session.cube.public_methods.map(&:to_s)).to include(*methods)
  end

  
end