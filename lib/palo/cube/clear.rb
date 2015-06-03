module Palo
  module Cube
    class Clear < Palo::Request
      def initialize(session)
        super(session)
        @request              = '/cube/clear'
        @request_params       = %w(database name_database cube name_cube area complete sid)
        @response_keys        = %w(cube name_cube number_dimensions dimensions number_cells number_filled_cells status type cube_token)
        @trim_quotes          = %w(name_cube)
        @single_response      = true
      end
    end
  end
end

<<-eos
  request url http://[SERVER]:[PORT]/cube/clear[?PARAMETER1=value[&...]]
  short description Clears a cube
  long description  Clears a region of a cube. An area of the cube has to specified. All elements within this area are cleared.
  parameters
  name  type  description
  database  identifier  Identifier of a database
  cube  identifier  Identifier of a cube
  area  area  Comma separated list of element identifier lists. An identifier list is separated by colons. The area is the cartesian product.
  complete  boolean (Optional) If complete is "1" then the whole cube - regardless of the specified area - will be cleared. It is not necessary to even specify the parameter "area" in this case. Default is to use "area".
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
