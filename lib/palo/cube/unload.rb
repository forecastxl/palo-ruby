module Palo
  module Cube
    class Unload < Palo::Request
      def initialize(session)
        super(session)
        @request              = '/cube/unload'
        @request_params       = %w(database cube sid)
        @response_keys        = %w(OK)
        @single_response      = true
      end
    end
  end
end

<<-eos
  request url http://[SERVER]:[PORT]/cube/unload[?PARAMETER1=value[&...]]
  short description Unloads cube data from memory.
  long description  
  parameters  
  name  type  description
  database  identifier  Identifier of a database
  cube  identifier  Identifier of a cube
  sid string  Session identifier for a server connection. Use the /server/login request to get a valid session identifier.
  result  
  # name  type  description
  0 OK  identifier  "1" means OK
eos