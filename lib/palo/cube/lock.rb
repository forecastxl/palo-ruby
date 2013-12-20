module Palo
  module Cube
    class Lock < Palo::Request
      def initialize(session)
        super(session)
        @request              = '/cube/lock'
        @request_params       = %w(database cube area complete sid)
        @response_keys        = %w(lock area user steps)
        @trim_quotes          = %w(user)
        @single_response      = true
      end
    end
  end
end

<<-eos
  request url http://[SERVER]:[PORT]/cube/lock[?PARAMETER1=value[&...]]
  short description locks a cube area
  long description  If an area is locked by an user, then only the user can make changes to the given area. All changes to the area are stored and can be reverted with the cube/rollback request. To delete the lock use the cube/commit (confirm changes) or the cube/rollback (undo changes) request.
  parameters  
  name  type  description
  database  identifier  Identifier of a database
  cube  identifier  Identifier of a cube
  area  area  Comma separated list of element identifiers list. Each element identifiers list is colon separated. The area is the cartesian product.
  complete  integer If 1 and no area is specified, special lock for whole cube is applied. No other user can read the cube and it's not sorted and markers are not generated until commit.
  sid string  Session identifier for a server connection. Use the /server/login request to get a valid session identifier.
  result  
  # name  type  description
  0 lock  integer Indentifier of the locked area
  1 area  area  Comma separated list of element identifiers list. Each element identifiers list is colon separated. The area is the cartesian product.
  2 user  string  The name of the user who locked the cube
  3 steps integer Number of steps
eos