module Palo
  module Cube
    class Locks < Palo::Request
      def initialize(session)
        super(session)
        @request              = '/cube/locks'
        @request_params       = %w(database cube sid)
        @response_keys        = %w(lock area user steps)
        @trim_quotes          = %w(user)
      end
    end
  end
end

<<-eos
  request url http://[SERVER]:[PORT]/cube/locks[?PARAMETER1=value[&...]]
  short description Lists the locked cube areas
  long description  
  parameters  
  name  type  description
  database  identifier  Identifier of a database
  cube  identifier  Identifier of a cube
  sid string  Session identifier for a server connection. Use the /server/login request to get a valid session identifier.
  result  
  # name  type  description
  0 lock  integer Indentifier of the locked area
  1 area  area  Comma separated list of element identifiers list. Each element identifiers list is colon separated. The area is the cartesian product.
  2 user  string  The name of the user who locked the cube
  3 steps integer Number of steps
eos