require 'spec_helper'

describe "Server" do
  let(:session) { Palo.login("127.0.0.1", "7777", "admin", "admin") }
  # let(:databases_response) { [
  #   ["1", "\"BedrijfX\"", "31", "32", "1", "0", "1377002785"],
  #   ["2", "\"3954bd568ad9026a6c7270a65b36cf65\"", "31", "32", "1", "0", "253233241"],
  #   ["4", "\"119f2a4823cf4fb13b88023a5f567954\"", "31", "32", "1", "0", "327488838"],
  #   ["5", "\"ManagementTool\"", "21", "21", "1", "0", "80786334"]
  # ] }
  let(:databases_response) { session.server.databases }

  it "returns a server object from a session" do
    expect(session.server).to be_an_instance_of(Palo::Server)
  end

  it "returns an array with databases" do
    # databases_response = session.server.databases
    #FIX wat test je hier nou dan eigenlijk met een nep response?
    expect(databases_response).to be_an(Array)
  end

  it "splits a response into a key value hash" do
    result = session.server.databases_parse_line(databases_response[0])
    expect(result).to be_a(Hash)
  end

  it "trims extra quotes from start of strings" do
    result = session.server.databases_parse_line(databases_response[0])
    expect(result['name_database']).not_to start_with("\"")
  end

  it "trims extra quotes from end of strings" do
    result = session.server.databases_parse_line(databases_response[0])
    expect(result['name_database']).not_to end_with("\"")
  end

  
end