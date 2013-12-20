module Palo
  module Server
    class Load < Palo::Request
      def initialize(session)
        super(session)
        @request              = '/server/load'
        @request_params       = %w(sid)
        @response_keys        = %w(OK)
        @single_response      = true
      end
    end
  end
end

<<-eos
  request url http://[SERVER]:[PORT]/server/load[?PARAMETER1=value[&...]]
  short description Reloads the server from disk
  long description  
  parameters  
  name  type  description
  sid string  Session identifier for a server connection. Use the /server/login request to get a valid session identifier.
  result  
  # name  type  description
  0 OK  boolean "1" means OK
eos