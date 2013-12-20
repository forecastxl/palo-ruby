require 'spec_helper'

describe "Cell" do
  let(:session) { Palo.login("127.0.0.1", "7777", "admin", "admin") }
  
  it "returns a cell object from a session" do
    expect(session.cell).to be_an_instance_of(Palo::Cell::Base)
  end

  it "returns a cell object with public methods" do
    methods = %w(area copy drillthrough export goalseek replace replace_bulk value values)
    expect(session.cell.public_methods.map(&:to_s)).to include(*methods)
  end

  
end