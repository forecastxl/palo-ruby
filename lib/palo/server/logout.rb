module Palo
  module Server
    class Logout < Palo::Request
      def initialize(session)
        super(session)
        @request              = '/server/logout'
        @request_params       = %w(sid)
        @response_keys        = %w(OK)
        @single_response      = true
      end
    end
  end
end

<<-eos
  request url http://[SERVER]:[PORT]/server/logout[?PARAMETER1=value[&...]]
  short description This request is used to close a connection
  long description  The session identifier can no longer be used after this request. It becomes invalid.
  parameters  
  name  type  description
  sid string  Session identifier for a server connection. Use the /server/login request to get a valid session identifier.
  result  
  # name  type  description
  0 OK  boolean "1" means OK
eos