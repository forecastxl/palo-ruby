module Palo
  module Cube
    class Rename < Palo::Request
      def initialize(session)
        super(session)
        @request              = '/cube/rename'
        @request_params       = %w(database name_database cube name_cube new_name sid)
        @response_keys        = %w(cube name_cube number_dimensions dimensions number_cells number_filled_cells status type cube_token)
        @trim_quotes          = %w(name_cube)
        @single_response      = true
      end
    end
  end
end

<<-eos
  request url http://[SERVER]:[PORT]/cube/rename[?PARAMETER1=value[&...]]
  short description Renames a cube
  long description
  parameters
  name  type  description
  database  identifier  Identifier of a database
  cube  identifier  Identifier of a cube
  new_name  string  New name of the cube
  sid string  Session identifier for a server connection. Use the /server/login request to get a valid session identifier.
  result
  # name  type  description
  0 cube  identifier  Identifier of the cube
  1 name_cube string  Name of the cube
  2 number_dimensions integer Number of dimensions
  3 dimensions  identifier  Comma separated list of dimension identifiers
  4 number_cells  integer Total number of cells
  5 number_filled_cells integer Number of filled numeric base cells plus number of filled string cells
  6 status  integer Status of cube (0=unloaded, 1=loaded and 2=changed)
  7 type  integer Type of cube (0=normal, 1=system, 2=attribute, 3=user info, 4=gpu type)
  8 cube_token  integer The cube token of the cube
eos
