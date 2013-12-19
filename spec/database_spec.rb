require 'spec_helper'

describe "Database" do
  let(:session) { Palo.login("127.0.0.1", "7777", "admin", "admin") }
  # let(:databases_response) { [
  #   ["1", "\"BedrijfX\"", "31", "32", "1", "0", "1377002785"],
  #   ["2", "\"3954bd568ad9026a6c7270a65b36cf65\"", "31", "32", "1", "0", "253233241"],
  #   ["4", "\"119f2a4823cf4fb13b88023a5f567954\"", "31", "32", "1", "0", "327488838"],
  #   ["5", "\"ManagementTool\"", "21", "21", "1", "0", "80786334"]
  # ] }
  # let(:databases_response) { session.server.databases }

  it "returns a server object from a session" do
    expect(session.database).to be_an_instance_of(Palo::Database::Base)
  end

  it "performs the cubes call" do
    databases = session.server.databases
    db_id = databases[0]['database']
    expect(session.database.cubes({ database: db_id })).to be_an_instance_of(Array)
  end

  it "does not perform the fake blaat call" do
    expect{ session.database.blaat }.to raise_error(NoMethodError)
  end

  
end