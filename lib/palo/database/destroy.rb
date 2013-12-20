module Palo
  module Database
    class Destroy < Palo::Request
      def initialize(session)
        super(session)
        @request              = '/database/destroy'
        @request_params       = %w(database sid)
        @response_keys        = %w(OK)
        @single_response      = true
      end
    end
  end
end

<<-eos
  request url http://[SERVER]:[PORT]/database/destroy[?PARAMETER1=value[&...]]
  short description Deletes a database
  long description  
  parameters  
  name  type  description
  database  identifier  Identifier of the database
  sid string  Session identifier for a server connection. Use the /server/login request to get a valid session identifier.
  result  
  # name  type  description
  0 OK  boolean "1" means OK
eos