module Palo
  module Cell
    class Goalseek < Palo::Request
      def initialize(session)
        super(session)
        @request              = '/cell/goalseek'
        @request_params       = %w(database cube path type area value sid)
        @response_keys        = %w(OK)
        @single_response      = true
      end
    end
  end
end

<<-eos
  request url http://[SERVER]:[PORT]/cell/goalseek[?PARAMETER1=value[&...]]
  short description Puts value into cell and calculates values for sister cells in order to parents remain unchanged.
  long description  
  parameters  
  name  type  description
  database  identifier  Identifier of a database
  cube  identifier  Identifier of a cube
  path  path  Target cell path. Comma separated list of element identifiers.
  type  integer The type of goal-seek algorithm. 0 complete allocation, 1 equal, 2 relative (0 default).
  area  area  Comma separated list of element identifiers list. Each element identifiers list is colon separated. Siblings to reallocate for each dimension (only for type 1 and 2).
  value double  The numeric value of the target cube cell.
  sid string  Session identifier for a server connection. Use the /server/login request to get a valid session identifier.
  result  
  # name  type  description
  0 OK  boolean "1" means OK
eos