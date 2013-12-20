module Palo
  module Cube
    class Commit < Palo::Request
      def initialize(session)
        super(session)
        @request              = '/cube/commit'
        @request_params       = %w(database cube lock sid)
        @response_keys        = %w(OK)
        @single_response      = true
      end
    end
  end
end

<<-eos
  request url http://[SERVER]:[PORT]/cube/commit[?PARAMETER1=value[&...]]
  short description commits changes of a locked cube area
  long description  
  parameters  
  name  type  description
  database  identifier  Identifier of a database
  cube  identifier  Identifier of a cube
  lock  integer Indentifier of the locked area
  sid string  Session identifier for a server connection. Use the /server/login request to get a valid session identifier.
  result  
  # name  type  description
  0 OK  boolean "1" means OK
eos