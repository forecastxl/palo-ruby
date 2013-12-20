module Palo
  module Server
    class Shutdown < Palo::Request
      def initialize(session)
        super(session)
        @request              = '/server/shutdown'
        @request_params       = %w(sid)
        @response_keys        = %w(OK)
        @single_response      = true
      end
    end
  end
end

<<-eos
  request url http://[SERVER]:[PORT]/server/shutdown[?PARAMETER1=value[&...]]
  short description Shuts down the server
  long description  
  parameters  
  name  type  description
  sid string  Session identifier for a server connection. Use the /server/login request to get a valid session identifier.
  result  
  # name  type  description
  0 OK  boolean "1" means OK
eos