module Palo
  module Server
    class Save < Palo::Request
      def initialize(session)
        super(session)
        @request              = '/server/save'
        @request_params       = %w(sid)
        @response_keys        = %w(OK)
        @single_response      = true
      end
    end
  end
end

<<-eos
  request url http://[SERVER]:[PORT]/server/save[?PARAMETER1=value[&...]]
  short description Saves the server to disk
  long description  This request saves the server data, i. e. identifiers and database names, to disk. To save database and cube data use the requests "/database/save" and "/cube/save".
  parameters  
  name  type  description
  sid string  Session identifier for a server connection. Use the /server/login request to get a valid session identifier.
  result  
  # name  type  description
  0 OK  boolean "1" means OK
eos