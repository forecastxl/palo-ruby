module Palo
  module Database
    class Unload < Palo::Request
      def initialize(session)
        super(session)
        @request              = '/database/unload'
        @request_params       = %w(database sid)
        @response_keys        = %w(OK)
        @single_response      = true
      end
    end
  end
end

<<-eos
  request url http://[SERVER]:[PORT]/database/unload[?PARAMETER1=value[&...]]
  short description Unloads a database from memory.
  long description  It is not possible to unload an unsaved database from memory.
  parameters  
  name  type  description
  database  identifier  Identifier of the database
  sid string  Session identifier for a server connection. Use the /server/login request to get a valid session identifier.
  result  
  # name  type  description
  0 OK  boolean "1" means OK
eos