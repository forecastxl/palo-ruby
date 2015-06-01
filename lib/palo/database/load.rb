module Palo
  module Database
    class Load < Palo::Request
      def initialize(session)
        super(session)
        @request              = '/database/load'
        @request_params       = %w(database name_database sid)
        @response_keys        = %w(OK)
        @single_response      = true
      end
    end
  end
end

<<-eos
  request url http://[SERVER]:[PORT]/database/load[?PARAMETER1=value[&...]]
  short description Loads a database from disk.
  long description  To load cube data use the request "/cube/load".
  parameters
  name  type  description
  database  identifier  Identifier of the database
  sid string  Session identifier for a server connection. Use the /server/login request to get a valid session identifier.
  result
  # name  type  description
  0 OK  integer "1" means OK
eos
